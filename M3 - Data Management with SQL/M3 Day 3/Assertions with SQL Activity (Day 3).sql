--28/09 we are doing the class activities from yesterday (Sesion 3):
--First Question: pg 20 ppt Sesion 3 
SELECT name, species, homeworld
FROM star_wars_characters
WHERE name LIKE "b%"; -- this is used to select only the names with B 

--Second Question: pg 21
SELECT DISTINCT homeworld -- to select values from a specific column
FROM star_wars_characters --the table that we are using
GROUP BY 1; -- will group automatically by alphabetical order A>Z

--Third Question: pg 22 ppt Sesion 3 
--First I can see the data that I have in a table in here:
SELECT * FROM jamesbond;
--But once the .csv file is uploaded, I can just directly put in the query that I want here.
SELECT film, director, year, actor --This part of the query specifies the columns you want to retrieve from the jamesbond table.
FROM jamesbond --It specifies the table from which you want to retrieve the data.
-- WHERE clause is used for filtering the results based on specified conditions:
WHERE year <= 2000 -- It filters movies released until the year 2000.
	AND (director = 'Lewis Gilbert' OR director = 'Martin Campbell') -- It filters movies directed by Lewis Gilbert or Martin Campbell.
    AND actor != 'Roger Moore'; --It excludes movies starring Roger Moore.
--Alternative to the previous 
SELECT film, director, year, actor
FROM jamesbond
WHERE year <= 2000
	AND (director LIKE 'Lewis%' OR director LIKE 'Martin%')
    AND actor NOT LIKE 'Roger%';

--Fourth Question: pg 23 ppt
--If I dont' see it in the .csv file I should at least be able to see my data here.
SELECT * FROM world_health_org;
--First I will need to identify the relevant columns
--The prompt I was given needs the following: I'll need columns that specify the country, its continent (African or European), literacy rate, and the ratio of the population living in urban areas.
--Combined Condition:
SELECT Country, continent, adult_literacy_rate, population_in_urban_areas
FROM world_health_org
WHERE (Continent = 'Africa' AND adult_literacy_rate BETWEEN 25 AND 75)
   OR (Continent = 'Europe' AND population_in_urban_areas < 50);
-- Selecting individual conditions
-- Condition 1:
SELECT Country, continent, adult_literacy_rate, population_in_urban_areas
FROM world_health_org
WHERE Continent = 'Africa' AND adult_literacy_rate BETWEEN 25 AND 75;
--Condition 2:
SELECT Country, continent, adult_literacy_rate, population_in_urban_areas
FROM world_health_org
WHERE Continent = 'Europe' AND population_in_urban_areas < 50;

--Fifth Question: pg 24 ppt
SELECT country, continent, gross_income_per_capita
FROM world_health_org
WHERE continent = 'Africa' --I was missing the specific continent in the prompt, filtering rows to include only African countries.
ORDER BY gross_income_per_capita DESC --And here I needed to order the GDP from highest value to lowest.
LIMIT 5; --And this is to say that I can only have the top 5 and no more.

--Sixth Question: pg 25 ppt 
SELECT * FROM imdb_movies;

--
SELECT ROW_NUMBER() OVER (ORDER BY imdb_score DESC) AS row,
    movie_title, 
    imdb_score, 
    country, 
    title_year
FROM imdb_movies
WHERE title_year >= 1980
   AND country NOT LIKE 'USA'
ORDER BY imdb_score DESC
LIMIT 10;

--
SELECT movie_title, imdb_score, country, title_year
FROM imdb_movies
WHERE title_year >= 1980
   AND country != 'USA'
ORDER BY imdb_score DESC
LIMIT 10;

