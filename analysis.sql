/* What day of the week do most users register on? */ 
SELECT DAYNAME(created_at) as day_created, COUNT(*) as total
FROM users
GROUP BY day_created
ORDER by total DESC 
LIMIT 1;

/* find the users who have never posted a photo */ 
SELECT username
FROM users 
LEFT JOIN photos ON photos.user_id = users.id 
WHERE photos.id IS NULL;

/* identify the most popular photo and user who created it */
SELECT photos.id, users.username, COUNT(*) as total
FROM photos 
JOIN likes on likes.photo_id = photos.id 
JOIN users on photos.user_id = users.id
GROUP BY photos.id 
ORDER BY total DESC 
LIMIT 1;

/* how many times does the average user post? */
SELECT (SELECT COUNT(*) FROM photos) / (SELECT COUNT(*) FROM users) as average;

/* what are the top 5 most commonly used hashtags? */
SELECT tags.tag_name, Count(*) as total
FROM photo_tags 
JOIN tags on photo_tags.tag_id = tags.id
group by tags.id
ORDER BY total DESC 
limit 5; 

/* find users who have liked every single photo on the site - likely a bot */
SELECT username, COUNT(*) AS num_likes 
FROM users 
INNER JOIN likes ON likes.user_id = users.id
GROUP BY users.username
HAVING num_likes = (SELECT COUNT(*) from photos);

