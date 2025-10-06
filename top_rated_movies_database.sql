-- 1. DATABASE SETUP

DROP DATABASE IF EXISTS top_rated_movies;
CREATE DATABASE top_rated_movies;
USE top_rated_movies;


-- 2. TABLE CREATION 


-- A. Creating movies table with all the movies data

CREATE TABLE movies(
    movie_id INT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    release_year INT,
    genre VARCHAR(100),
    rating DECIMAL(2,1),
    director_id INT
);

-- B. Creating directors table that contains the directors data

CREATE TABLE directors(
    director_id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    birth_year INT,
    nationality VARCHAR(50)
);

-- C. Creating a table which includes the cast of each movie

CREATE TABLE casts(
    movie_id INT,
    actor_id INT,
    role_name VARCHAR(255) NOT NULL,
    PRIMARY KEY(movie_id,actor_id)
);

-- D. Creating a table with all the actors data

CREATE TABLE actors(
    actor_id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    gender VARCHAR(50),
    nationality VARCHAR(50)
);

-- E. Creating a table that contains box-office records

CREATE TABLE box_office(
    movie_id INT PRIMARY KEY,
    domestic_gross NUMERIC,
    worldwide_gross NUMERIC
);

--# Adding Foreign Key Constraints

--setting director_id as foreign key in movies table

ALTER TABLE movies
ADD CONSTRAINT fk_directors
FOREIGN KEY(director_id)
REFERENCES directors(director_id);

--setting movie_id & actor_id as foreign key in casts table

ALTER TABLE casts
ADD CONSTRAINT fk_movies
FOREIGN KEY(movie_id)
REFERENCES movies(movie_id);

ALTER TABLE casts
ADD CONSTRAINT fk_actors
FOREIGN KEY(actor_id)
REFERENCES actors(actor_id);

--setting movie_id as foreign key in box_office table

ALTER TABLE box_office
ADD CONSTRAINT fk_movie_id
FOREIGN KEY(movie_id)
REFERENCES movies(movie_id);


-- 3. DATA POPULATION


-- A. Populating directors table

INSERT INTO 
    directors(director_id,name,birth_year,nationality)
VALUES
    (101, 'Christopher Nolan', 1970, 'British'), 
    (102, 'Francis Ford Coppola', 1939, 'American'),
    (103, 'Frank Darabont', 1959, 'Hungarian-American'),
    (104, 'Quentin Tarantino', 1963, 'American'),
    (105, 'Steven Spielberg', 1946, 'American'),
    (106, 'Peter Jackson', 1961, 'New Zealander'),
    (107, 'David Fincher', 1962, 'American');

-- B. Populating movies table

INSERT INTO 
    movies(movie_id, title, release_year, genre, rating, director_id)
VALUES
    (1, 'The Shawshank Redemption', 1994, 'Drama', 9.3, 103),
    (2, 'The Dark Knight', 2008, 'Action', 9.0, 101),
    (3, 'The Godfather', 1972, 'Crime', 9.2, 102),
    (4, 'Pulp Fiction', 1994, 'Crime', 8.9, 104),
    (5, 'Inception', 2010, 'Sci-Fi', 8.8, 101),
    (6, 'Schindler''s List', 1993, 'History', 9.0, 105),
    (7, 'The Lord of the Rings: The Return of the King', 2003, 'Fantasy', 9.0, 106),
    (8, 'Fight Club', 1999, 'Drama', 8.8, 107),
    (9, 'Interstellar', 2014, 'Sci-Fi', 8.6, 101),
    (10, 'The Silence of the Lambs', 1991, 'Thriller', 8.6, 107);

-- C. Populating actors table

INSERT INTO 
    actors(actor_id,name,gender,nationality)
VALUES
    -- Shawshank Redemption 
(201, 'Tim Robbins', 'Male', 'American'),
(202, 'Morgan Freeman', 'Male', 'American'),

-- The Dark Knight 
(203, 'Christian Bale', 'Male', 'British'),
(204, 'Heath Ledger', 'Male', 'Australian'),

-- The Godfather 
(205, 'Marlon Brando', 'Male', 'American'),
(206, 'Al Pacino', 'Male', 'American'),

-- Pulp Fiction 
(207, 'John Travolta', 'Male', 'American'),
(208, 'Uma Thurman', 'Female', 'American'),

-- Inception 
(209, 'Leonardo DiCaprio', 'Male', 'American'),

-- Lord of the Rings 
(210, 'Ian McKellen', 'Male', 'British');

-- Interstellar
(211, 'Matthew McConaughey', 'Male', 'American')

-- The Silence of the Lambs
(212, 'Anthony Hopkins', 'Male', 'Welsh')

-- Fight Club
(213, 'Brad Pitt', 'Male', 'American')

-- D. Populating casts table

INSERT INTO 
    casts(movie_id,actor_id,role_name)
VALUES
    (1, 201, 'Andy Dufresne'),
    (1, 202, 'Ellis "Red" Redding'),
    (2, 203, 'Bruce Wayne / Batman'),
    (2, 204, 'The Joker'),
    (3, 206, 'Michael Corleone'),
    (4, 207, 'Vincent Vega'),
    (4, 208, 'Mia Wallace'),
    (5, 209, 'Cobb'),
    (7, 210, 'Gandalf'),  
    (8, 213, 'The Narrator / Tyler Durden'),
    (9, 211, 'Cooper'),
    (10, 212, 'Hannibal Lecter');


-- E. Populating box_office table

INSERT INTO 
    box_office(movie_id,domestic_gross,worldWide_gross)
VALUES
    (1, 28341469.00, 28341469.00),     -- The Shawshank Redemption
    (2, 534858444.00, 1004934033.00),  -- The Dark Knight
    (3, 134966411.00, 246120974.00),   -- The Godfather
    (4, 107928762.00, 213928762.00),   -- Pulp Fiction
    (5, 292576195.00, 836836967.00),   -- Inception
    (6, 96898818.00, 321306305.00),    -- Schindler's List
    (7, 377845905.00, 1146121665.00),  -- LOTR: Return of the King
    (8, 37033100.00, 100853753.00),    -- Fight Club
    (9, 188020017.00, 773000000.00);   -- Interstellar


-- 4. READING DATA


-- A. Simple Two-Table Join (Movies and Directors)
-- GOAL: To obtain the top 3 most rated movies and it's directors

SELECT 
    m.title,
    d.name
FROM movies AS m 
JOIN directors AS d ON
    m.director_id = d.director_id
ORDER BY
    m.rating DESC
LIMIT 3;

 -- B. Three Table Join (Movies,Casts & Actors)
 -- GOAL : To obtain the name and role of the actor in the movie 'Inception'

SELECT 
    m.title AS movie_title,
    a.name AS actor,
    c.role_name 
FROM movies AS m
JOIN casts AS c ON
    m.movie_id = c.movie_id
JOIN actors AS a ON
    c.actor_id = a.actor_id
WHERE m.title = 'Inception';

-- C. Box-office Analysis
-- GOAL : To find the top 5 movies based on their average world wide gross and average movie rating

SELECT 
    m.title,
    ROUND(AVG(m.rating),1) AS avg_rating,
    ROUND(AVG(b.worldwide_gross)) AS avg_worldwide_gross
FROM movies AS m
JOIN box_office AS b ON
    m.movie_id = b.movie_id
GROUP BY 
    m.title
ORDER BY
    avg_worldwide_gross DESC,
    avg_rating DESC
LIMIT 5;


-- 5. UPDATING DATA 

-- A. Fixing the movie rating
-- GOAL : To correct the rating of 'The Godfather' from 9.2 to 9.3

UPDATE movies
SET rating = 9.3
WHERE title = 'The Godfather';

--Verification

SELECT *
FROM movies
WHERE title ='The Godfather';


--B. Fixing the actor id 
-- GOAL : To correct the actor_id in the movies 'Interstellar','The Silence of the Lambs' & 'Fight Club'

UPDATE casts
SET actor_id = 211
WHERE movie_id = 9;

UPDATE casts
SET actor_id = 212
WHERE movie_id = 10;

UPDATE casts
SET actor_id = 213
WHERE movie_id = 8;

--Verification

SELECT *
FROM casts
WHERE movie_id IN(8,9,10);


-- 6. DELETING DATA

-- A. Deleting a Relationship Record 
-- GOAL : To remove the relationship record for the actor 'Ian Mckellen' from the movie 'The Lord of the rings'

DELETE FROM casts
WHERE 
    movie_id = 7 AND
    actor_id = 210;

--Verification

SELECT *
FROM casts
WHERE 
    movie_id = 7 AND
    actor_id = 210;


-- B. Deleting a Primary entity by inserting a temporary director data
-- GOAL :To demonstrate the deletion of a simple, unlinked entity

--Step 1. Inserting temporary data into directors table

INSERT INTO directors
VALUES(108,'John Doe',1987,'British');

--Step 2. Deleting the director record

DELETE FROM directors
WHERE director_id = 108;

--Verification

SELECT *
FROM directors
WHERE director_id = 108;

--#######################################################################################
