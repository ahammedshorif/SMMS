CREATE TABLE users (
    user_id INT IDENTITY(1,1) PRIMARY KEY,
    username VARCHAR(255) UNIQUE NOT NULL,
    profile_photo_url VARCHAR(255) DEFAULT 'https://picsum.photos/100',
    bio VARCHAR(255),
    created_at DATETIME DEFAULT GETDATE(),
	email VARCHAR(30) NOT NULL
);


CREATE TABLE photos (
    photo_id INT IDENTITY(1,1) PRIMARY KEY,
    photo_url VARCHAR(255) NOT NULL UNIQUE,
    post_id INT NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    size FLOAT,
    CONSTRAINT CHK_Photo_Size CHECK (size < 5)
);

CREATE TABLE videos (
    video_id INT IDENTITY(1,1) PRIMARY KEY,
    video_url VARCHAR(255) NOT NULL UNIQUE,
    post_id INT NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    size FLOAT,
    CONSTRAINT CHK_Video_Size CHECK (size < 10)
);

CREATE TABLE post (
    post_id INT IDENTITY(1,1) PRIMARY KEY,
    photo_id INT,
    video_id INT,
    user_id INT NOT NULL,
    caption VARCHAR(200), 
    location VARCHAR(50),
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY(user_id) REFERENCES users(user_id),
    FOREIGN KEY(photo_id) REFERENCES photos(photo_id),
    FOREIGN KEY(video_id) REFERENCES videos(video_id)
);

CREATE TABLE comments (
    comment_id INT IDENTITY(1,1) PRIMARY KEY,
    comment_text VARCHAR(255) NOT NULL,
    post_id INT NOT NULL,
    user_id INT NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY(post_id) REFERENCES post(post_id),
    FOREIGN KEY(user_id) REFERENCES users(user_id)
);

CREATE TABLE post_likes (
    user_id INT NOT NULL,
    post_id INT NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY(user_id) REFERENCES users(user_id),
    FOREIGN KEY(post_id) REFERENCES post(post_id),
    PRIMARY KEY(user_id, post_id)
);

CREATE TABLE comment_likes (
    user_id INT NOT NULL,
    comment_id INT NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY(user_id) REFERENCES users(user_id),
    FOREIGN KEY(comment_id) REFERENCES comments(comment_id),
    PRIMARY KEY(user_id, comment_id)
);

CREATE TABLE follows (
    follower_id INT NOT NULL,
    followee_id INT NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY(follower_id) REFERENCES users(user_id),
    FOREIGN KEY(followee_id) REFERENCES users(user_id),
    PRIMARY KEY(follower_id, followee_id)
);

CREATE TABLE hashtags (
    hashtag_id INT IDENTITY(1,1) PRIMARY KEY,
    hashtag_name VARCHAR(255) UNIQUE,
    created_at DATETIME DEFAULT GETDATE()
);

CREATE TABLE hashtag_follow (
    user_id INT NOT NULL,
    hashtag_id INT NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY(user_id) REFERENCES users(user_id),
    FOREIGN KEY(hashtag_id) REFERENCES hashtags(hashtag_id),
    PRIMARY KEY(user_id, hashtag_id)
);

CREATE TABLE post_tags (
    post_id INT NOT NULL,
    hashtag_id INT NOT NULL,
    FOREIGN KEY(post_id) REFERENCES post(post_id),
    FOREIGN KEY(hashtag_id) REFERENCES hashtags(hashtag_id),
    PRIMARY KEY(post_id, hashtag_id)
);

CREATE TABLE bookmarks (
    post_id INT NOT NULL,
    user_id INT NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY(post_id) REFERENCES post(post_id),
    FOREIGN KEY(user_id) REFERENCES users(user_id),
    PRIMARY KEY(user_id, post_id)
);

CREATE TABLE login (
    login_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    ip VARCHAR(50) NOT NULL,
    login_time DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY(user_id) REFERENCES users(user_id)
);





-- Insert into users
INSERT INTO users (username, email, profile_photo_url, bio)
VALUES 
('Tanvir', 'tanvir@gmail.com', 'https://picsum.photos/id/1/100', 'Loves photography'),
('Rakib', 'rakib@gmail.com', 'https://picsum.photos/id/2/100', 'Traveler'),
('Shakib', 'shakib@gmail.com', 'https://picsum.photos/id/3/100', 'Food blogger'),
('Nayeem', 'nayeem@gmail.com', 'https://picsum.photos/id/4/100', 'Tech enthusiast'),
('Ayesha', 'ayesha@email.com', 'https://picsum.photos/id/5/100', 'Fashion designer'),
('Sajid', 'sajid@email.com', 'https://picsum.photos/id/6/100', 'Nature lover'),
('Nusrat', 'nusrat@gmail.com', 'https://picsum.photos/id/7/100', 'Artist'),
('Kazi', 'kazi@email.com', 'https://picsum.photos/id/8/100', 'Photographer'),
('Rahim', 'rahim@email.com', 'https://picsum.photos/id/9/100', 'Traveler'),
('Karim', 'karim@email.com', 'https://picsum.photos/id/10/100', 'Blogger');

-- Insert into photos
INSERT INTO photos (photo_url, post_id, size)
VALUES 
('https://picsum.photos/id/20/200', 1, 4.5),
('https://picsum.photos/id/21/200', 2, 3.2),
('https://picsum.photos/id/22/200', 3, 4.7),
('https://picsum.photos/id/23/200', 4, 2.9),
('https://picsum.photos/id/24/200', 5, 4.1),
('https://picsum.photos/id/25/200', 6, 3.8),
('https://picsum.photos/id/26/200', 7, 4.0),
('https://picsum.photos/id/27/200', 8, 3.5),
('https://picsum.photos/id/28/200', 9, 4.3),
('https://picsum.photos/id/29/200', 10, 4.2);

-- Insert into videos
INSERT INTO videos (video_url, post_id, size)
VALUES 
('https://example/video3.mp4', 1, 8.5),
('https://example.com/video4.mp4', 2, 7.3),
('https://example.com/video5.mp4', 3, 8.1),
('https://example.com/video6.mp4', 4, 9.2),
('https://example.com/video7.mp4', 5, 7.8),
('https://example.com/video8.mp4', 6, 8.6),
('https://example.com/video9.mp4', 7, 7.5),
('https://example.com/video10.mp4', 8, 9.0),
('https://example.com/video11.mp4', 9, 8.3),
('https://example.com/video12.mp4', 10, 9.1);

-- Insert into post

INSERT INTO post (photo_id, video_id, user_id, caption, location)
VALUES 
(1, NULL, 1, 'Beautiful sunrise!', 'Beach'),
(NULL, 1, 2, 'Check out this video', 'Home'),
(2, NULL, 3, 'Lovely nature!', 'Park'),
(NULL, 2, 4, 'Amazing tech review', 'Office'),
(3, NULL, 5, 'Great fashion tips!', 'Studio'),
(NULL, 3, 6, 'Nature at its best', 'Mountain'),
(4, NULL, 7, 'Art exhibition', 'Gallery'),
(NULL, 4, 8, 'Photography tips', 'Street'),
(5, NULL, 9, 'Travel adventures', 'Jungle'),
(NULL, 5, 10, 'Blogger insights', 'Cafe');

-- Insert into comments

INSERT INTO comments (comment_text, post_id, user_id)
VALUES 
('Awesome post!', 1, 2),
('Thanks for sharing!', 2, 3),
('Love this!', 3, 4),
('Very informative!', 4, 5),
('Great tips!', 5, 6),
('Beautiful!', 6, 7),
('Interesting!', 7, 8),
('Amazing!', 8, 9),
('Well done!', 9, 10),
('Nice post!', 10, 1);

-- Insert into post_likes

INSERT INTO post_likes (user_id, post_id)
VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

-- Insert into comment_likes

INSERT INTO comment_likes (user_id, comment_id)
VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

-- Insert into follows

INSERT INTO follows (follower_id, followee_id)
VALUES 
(1, 2),
(2, 3),
(3, 4),
(4, 5),
(5, 6),
(6, 7),
(7, 8),
(8, 9),
(9, 10),
(10, 1);

-- Insert into hashtags
INSERT INTO hashtags (hashtag_name)
VALUES 
('#sunrise'),
('#travel'),
('#nature'),
('#tech'),
('#fashion'),
('#art'),
('#photography'),
('#adventure'),
('#blogger'),
('#tips');

-- Insert into hashtag_follow

INSERT INTO hashtag_follow (user_id, hashtag_id)
VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

-- Insert into post_tags

INSERT INTO post_tags (post_id, hashtag_id)
VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

-- Insert into bookmarks

INSERT INTO bookmarks (post_id, user_id)
VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

-- Insert into login

INSERT INTO login (user_id, ip)
VALUES 
(1, '192.168.1.1'),
(2, '192.168.1.2'),
(3, '192.168.1.3'),
(4, '192.168.1.4'),
(5, '192.168.1.5'),
(6, '192.168.1.6'),
(7, '192.168.1.7'),
(8, '192.168.1.8'),
(9, '192.168.1.9'),
(10, '192.168.1.10');




---------------------------



-- 1.Select all users

SELECT * FROM users;

--2.Select all posts with their associated user information

SELECT p.post_id, p.caption, p.location, p.created_at, u.username, u.email
FROM post p
JOIN users u ON p.user_id = u.user_id;

--3.Select all comments on a specific post

SELECT c.comment_text, u.username, c.created_at
FROM comments c
JOIN users u ON c.user_id = u.user_id
WHERE c.post_id = 1;

--4.Select all photos and videos of a specific user

SELECT ph.photo_url, ph.size AS photo_size, v.video_url, v.size AS video_size
FROM post p
LEFT JOIN photos ph ON p.photo_id = ph.photo_id
LEFT JOIN videos v ON p.video_id = v.video_id
WHERE p.user_id = 1;


--5.Select the number of likes on each post

SELECT p.post_id, p.caption, COUNT(pl.user_id) AS like_count
FROM post p
LEFT JOIN post_likes pl ON p.post_id = pl.post_id
GROUP BY p.post_id, p.caption;


-- 6. Select the number of comments on each post
SELECT p.post_id, p.caption, COUNT(c.comment_id) AS comment_count
FROM post p
LEFT JOIN comments c ON p.post_id = c.post_id
GROUP BY p.post_id, p.caption;

-- 7. Select the followers of a specific user
SELECT u.username AS follower
FROM follows f
JOIN users u ON f.follower_id = u.user_id
WHERE f.followee_id = 1;

-- 8. Select the users followed by a specific user
SELECT u.username AS followee
FROM follows f JOIN users u ON f.followee_id = u.user_id
WHERE f.follower_id = 1;

-- 9. Select posts with a specific hashtag
SELECT p.post_id, p.caption, h.hashtag_name
FROM post_tags pt
JOIN post p ON pt.post_id = p.post_id
JOIN hashtags h ON pt.hashtag_id = h.hashtag_id
WHERE h.hashtag_name = '#sunrise';

-- 10. Select users who liked a specific post
SELECT u.username
FROM post_likes pl
JOIN users u ON pl.user_id = u.user_id
WHERE pl.post_id = 4;

-- 11. Select users who liked a specific comment
SELECT u.username
FROM comment_likes cl
JOIN users u ON cl.user_id = u.user_id
WHERE cl.comment_id = 1;

-- 12. Select all hashtags followed by a specific user
SELECT h.hashtag_name
FROM hashtag_follow hf
JOIN hashtags h ON hf.hashtag_id = h.hashtag_id
WHERE hf.user_id = 1;

-- 13. Select all bookmarks of a specific user
SELECT p.post_id, p.caption
FROM bookmarks b
JOIN post p ON b.post_id = p.post_id
WHERE b.user_id = 1;

-- 14. Select all login records of a specific user
SELECT l.login_time, l.ip
FROM login l
WHERE l.user_id = 1;

-- 15. Select posts created within the last 15 days
SELECT p.post_id,p.caption,  p.created_at       
FROM post p
WHERE p.created_at >= DATEADD(DAY, -15, GETDATE());