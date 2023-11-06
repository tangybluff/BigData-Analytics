--I will import the dataset 'imdb_movies' and then I will create a new table.
--I will then filter out all the irrelevant data to create a new table with the data I want to use for my objectives and SQL queries.
CREATE TABLE movies_by_title AS
--AS is used to say that I am creating a new table based on the result of the SELECT query:
	SELECT movie_title, title_year, duration, director_me, language, country, imdb_score
    FROM imdb_movies;

-- I've created a new table from the previous dataset so that I can focus more on what I want to analyze.
SELECT * FROM movies_by_title ORDER BY movie_title; -- I want to see the new table ordered alphabetically. 
SELECT director_me, AVG(imdb_score) FROM movies_by_title GROUP BY director_me;
/*
-'director_me' is the name of the column by which to group the data
-AVG(imdb_score) calculates the average IMDb score for each director
-the 'GROUP BY director_me' clause groups the data by the director_me column, to get the average IMDb score for each unique director in the dataset
*/

--First I want to see all the data in my table but with the movie titles in alphabetical order.
SELECT * FROM movies_by_title ORDER BY movie_title;

--I will then start with my first few SQL queries. Clean up queries as you go along.
--Count movies by language and country.
SELECT country, language, COUNT(*) AS movie_count
	FROM movies_by_title
    GROUP BY country, language 
    ORDER BY country, movie_count DESC;

--Average IMDb Score by Title Year
SELECT title_year, AVG(imdb_score) AS avg_imdb_score 
	FROM movies_by_title 
    GROUP BY title_year 
    ORDER BY title_year;

--Count Movies by Director
SELECT director_me, COUNT(*) AS movie_count
	FROM movies_by_title
	GROUP BY director_me
	ORDER BY movie_count DESC;

--The following will be my first orientative GROUP BY queries.
/*Identify Directors with a Variety of Languages
Question: Which directors have directed movies in more than one language?*/
SELECT director_me, COUNT(DISTINCT language) AS language_count
	FROM movies_by_title
	GROUP BY director_me
	HAVING COUNT(DISTINCT language) > 1
	ORDER BY language_count DESC;

/*Find Years with High Average IMDb Scores
Question: Identify years with an average IMDb score greater than 7.5 for the movies released in those years.*/
SELECT title_year, AVG(imdb_score) AS avg_imdb_score
	FROM movies_by_title
	GROUP BY title_year
	HAVING AVG(imdb_score) > 7.5
	ORDER BY avg_imdb_score DESC;

/*Find Directors with High Average IMDb Scores
Question: Which directors have an average IMDb score greater than 8.0 for their movies?*/
SELECT director_me, AVG(imdb_score) AS avg_imdb_score
	FROM movies_by_title
	GROUP BY director_me
	HAVING AVG(imdb_score) >= 5.0 --Greater than or equal to
	ORDER BY avg_imdb_score DESC;

--Simple Questions to ask in the dataset to orient myself before asking complex questions.
--How many movies are there in the dataset?
SELECT COUNT (*) AS total_movies --will select all columns and count all the rows in the specified column while excluding NULL values
	FROM movies_by_title;

--What is the average IMDb score of all movies?
SELECT AVG(imdb_score) AS avg_imdb_score
	FROM movies_by_title;

--How many movies are in English?
SELECT COUNT(*) AS english_movies
	FROM movies_by_title
	WHERE language = 'English';

--What are the top 5 countries with the most movies in the dataset?
SELECT country, COUNT(*) AS movie_count
	FROM movies_by_title
	GROUP BY country
	ORDER BY movie_count DESC
	LIMIT 5;

--Complex Questions to ask in the dataset that are a combination of simple questions.
--What is the average IMDb score for movies released in each year, and which year had the highest average IMDb score?
SELECT title_year, AVG(imdb_score) AS avg_imdb_score
	FROM movies_by_title
	GROUP BY title_year
	ORDER BY avg_imdb_score DESC
	LIMIT 10;

--Identify the top 5 directors with the highest average IMDb scores, considering only directors who have directed movies in at least two different languages.
SELECT director_me, COUNT(DISTINCT language) AS language_count, AVG(imdb_score) AS avg_imdb_score
	FROM movies_by_title
	GROUP BY director_me
	HAVING language_count >= 2
	ORDER BY avg_imdb_score DESC
	LIMIT 5;

--For each year, find the language with the most movies released, and also calculate the total count of movies released in that language for that year.
/*This is the main query that retrieves information about the maximum number of movies (movie_count) for each combination of "title_year" and "language" from the "movies_by_title" table.*/
SELECT title_year, language, MAX(movie_count) AS max_language_count
	FROM (
/*This is a subquery or inner query that calculates the movie counts for each combination of "title_year" and "language".*/
  		SELECT title_year, language, COUNT(*) AS movie_count
  		FROM movies_by_title
  		GROUP BY title_year, language
		) subquery
/*The results from the subquery are grouped again by "title_year" and "language" in the outer query.
	-inner query (subquery): embedded or nested within another query (the outer query); executed first to produce intermediate results that are then processed by the outer query
    -outer query: the main SQL query that surrounds or contains the inner query*/
	GROUP BY title_year, language;

--Learn SQL first, cry later.
