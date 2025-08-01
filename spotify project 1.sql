-- create table
DROP TABLE IF EXISTS spotify;
CREATE TABLE spotify (
    artist VARCHAR(255),
    track VARCHAR(255),
    album VARCHAR(255),
    album_type VARCHAR(50),
    danceability FLOAT,
    energy FLOAT,
    loudness FLOAT,
    speechiness FLOAT,
    acousticness FLOAT,
    instrumentalness FLOAT,
    liveness FLOAT,
    valence FLOAT,
    tempo FLOAT,
    duration_min FLOAT,
    title VARCHAR(255),
    channel VARCHAR(255),
    views FLOAT,
    likes BIGINT,
    comments BIGINT,
    licensed BOOLEAN,
    official_video BOOLEAN,
    stream BIGINT,
    energy_liveness FLOAT,
    most_played_on VARCHAR(50)
);
SELECT * FROM spotify;

--Q1 Retrieve the name of streams with 1 billion views
WHERE stream > '1000000000' 

SELECT DISTINCT album, artist FROM spotify
ORDER BY 1


SELECT SUM(comments) FROM spotify
WHERE licensed = 'true'

SELECT * FROM spotify
WHERE album_type = 'single'

SELECT artist, COUNT (*) as total_no_somgs FROM spotify
GROUP BY artist ORDER BY 2 

--Medium level solutions--

SELECT album, avg (danceability) as avg_danceability FROM spotify
GROUP BY 1
ORDER BY 2 DESC

SELECT track, MAX(energy) 
FROM spotify
GROUP BY artist
ORDER BY 2 DESC

SELECT 
   track, 
   SUM(views) as total_views,
   SUM(likes) as total_likes
  FROM spotify
  WHERE official_video = 'true'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

SELECT album,
track,
SUM(views)
FROM spotify
GROUP BY 1, 2
ORDER BY 3 DESC


SELECT * FROM spotify
(SELECT track,
--most_played_on,
COALESCE(c,0)streamed_on_youtube
COALESCE ( ()   ,0) as streamed_on_spotify
FROM spotify
GROUP BY 1)

--ADVANCED PROBLEM--

WITH ranking_artist AS
(SELECT 
artist,
track,
SUM(views) as total_view,
DENSE_RANK() OVER(PARTITION BY artist ORDER BY SUM(views)DESC) as rank
FROM spotify
GROUP BY 1,2
ORDER BY 1,3 DESC
)
SELECT * FROM ranking_artist
WHERE rank <= 3


SELECT track,
artist,
liveness
FROM spotify 
WHERE liveness >( SELECT AVG(liveness) FROM spotify)


WITH cte AS
(SELECT 
album,
MAX(energy) as highest_energy,
MIN(energy) as lowest_energy
FROM spotify
GROUP BY 1)

SELECT 
album,highest_energy - lowest_energy as enrergy_diff
FROM cte


