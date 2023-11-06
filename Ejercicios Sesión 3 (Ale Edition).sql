-- Sesión 3 - Data Management
-- Primera Pregunta
SELECT NAME, species, homeworld
FROM star_wars_characters
where name like "b%";

-- Segunda Pregunta
select DISTINCT homeworld
from star_wars_characters;


-- Tercera Pregunta 

select film, director, year, actor
from jamesbond
where year <= 2000
and (director like 'Lewis%' or director like 'Martin%')
and actor != 'Roger Moore';
--and actor not like 'Roger%';


-- Cuarta Pregunta
SELECT country, continent, adult_literacy_rate, population_in_urban_areas
from world_health_org
where (continent = 'Africa' and adult_literacy_rate BETWEEN 25 and 75)
or (continent = 'Europe' and population_in_urban_areas < 50)
--and adult_literacy_rate > 25 and adult_literacy_rate <75 
--and population_in_urban_areas < 50

-- Quinta Pregunta

select country, continent, gross_income_per_capita
from world_health_org
where continent = 'Africa' 
order by gross_income_per_capita DESC
limit 5;

-- Sexta Pregunta

select movie_title, director_me, imdb_score
from imdb_movies
where title_year >= 1980 and country not like 'USA'
order by imdb_score desc 
limit 10;



