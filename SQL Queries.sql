CREATE TABLE movies_temp AS TABLE movies_partitioned;

DROP TABLE IF EXISTS movies_partitioned CASCADE;

CREATE TABLE movies_partitioned (
    "Id" SERIAL,
    "Title" VARCHAR(255),
    "Genre" VARCHAR(100),
    "Director" VARCHAR(255),
    "ReleaseYear" INT,
    "WatchCount" INT,
    "Rating" DOUBLE PRECISION,
    PRIMARY KEY ("Id", "ReleaseYear") 
) PARTITION BY RANGE ("ReleaseYear");

CREATE TABLE movies_2010_2019 PARTITION OF movies_partitioned
    FOR VALUES FROM (2010) TO (2020);  

CREATE TABLE movies_2020 PARTITION OF movies_partitioned
    FOR VALUES FROM (2020) TO (2021);  

CREATE TABLE movies_2021 PARTITION OF movies_partitioned
    FOR VALUES FROM (2021) TO (2022); 
	
CREATE INDEX idx_movies_genre ON movies_partitioned ("Genre");
CREATE INDEX idx_movies_director ON movies_partitioned ("Director");

CREATE INDEX idx_movies_2010_2019_genre ON movies_2010_2019 ("Genre");
CREATE INDEX idx_movies_2020_genre ON movies_2020 ("Genre");
CREATE INDEX idx_movies_2021_genre ON movies_2021 ("Genre");

CREATE INDEX idx_movies_2010_2019_director ON movies_2010_2019 ("Director");
CREATE INDEX idx_movies_2020_director ON movies_2020 ("Director");
CREATE INDEX idx_movies_2021_director ON movies_2021 ("Director");

INSERT INTO movies_partitioned ("Title", "Genre", "Director", "ReleaseYear", "WatchCount", "Rating")
SELECT movies_temp."Title", movies_temp."Genre", movies_temp."Director", movies_temp."ReleaseYear", movies_temp."WatchCount", movies_temp."Rating"
FROM movies_temp;

DROP TABLE movies_temp;

select count(*) from movies_2021;
select count(*) from movies_2020;
select count(*) from movies_2010_2019;

select count(*) from movies_partitioned ;

INSERT INTO movies_partitioned ("Title", "Genre", "Director", "ReleaseYear", "WatchCount", "Rating")
SELECT
    'Movie_' || (1000000 + series)::TEXT AS Title,            
    CASE
        WHEN RANDOM() < 0.2 THEN 'Action'
        WHEN RANDOM() < 0.4 THEN 'Comedy'
        WHEN RANDOM() < 0.6 THEN 'Drama'
        WHEN RANDOM() < 0.8 THEN 'Horror'
        ELSE 'Sci-Fi'
    END AS Genre,                                                
    'Director_' || (FLOOR(RANDOM() * 1000)::INT) AS Director,   
 	CASE
        WHEN RANDOM() < 0.33 THEN FLOOR(RANDOM() * 10 + 2010) 
        WHEN RANDOM() < 0.66 THEN 2020                         
        ELSE 2021                                             
    END AS ReleaseYear,       FLOOR(RANDOM() * 1000 + 1)::INT AS WatchCount,             
	ROUND(CAST(RANDOM() * 10 AS numeric), 1) AS Rating   
FROM generate_series(1, 2000000) AS series;

select count(*) from movies_2021;
select count(*) from movies_2020;
select count(*) from movies_2010_2019;

select count(*) from movies_partitioned ;


CREATE MATERIALIZED VIEW Top_10_Movies_By_Genre AS
SELECT "Genre", "Title", "Id", "Director", "ReleaseYear", "WatchCount", "Rating"
FROM movies_partitioned
WHERE "Genre" IS NOT NULL
ORDER BY "WatchCount" DESC
LIMIT 10;

REFRESH MATERIALIZED VIEW public."Top_10_Movies_By_Genre";
