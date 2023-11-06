--Retrieve the unique cities and their respective countries from the 'air_pollution_pm' table.
SELECT DISTINCT City, Country_Name FROM air_pollution_pm;

--Find the year with the highest total air pollution-related deaths from the 'death_rates' table.
SELECT Year, MAX("Air_pollution_(total)_(deaths_per_100,000)") AS "Max Deaths"
FROM death_rates;

--Calculate the average PM2.5 levels ('PM2.5_(μg/m3)') for each city in a specific year from the 'air_pollution_pm' table. 
SELECT Year, City, AVG("PM2.5_(μg/m3)") AS "Average PM2.5 Level"
FROM air_pollution_pm
WHERE Year = 2020  -- Replace with the desired year
GROUP BY Year, City;

--Retrieve the top 10 countries with the highest manufacturing output in the year 2000 from the 'global_top_manufact' table.
SELECT Country, "2000" AS "Manufacturing Output (2000)"
FROM global_top_manufact
ORDER BY "Manufacturing Output (2000)" DESC
LIMIT 10;

--Find the country with the highest percentage of the population living below $1.90 a day ('below_1.90$a_day(World_Bank_(2019))') in the year 2015 from the 'poverty_population_distribution' table.
SELECT Country, "below_1.90$_a_day_(World_Bank_(2019))" AS "Percentage Below $1.90 (2015)"
FROM poverty_population_distribution
WHERE Year = 2015 AND Country IS NOT 'World'
ORDER BY "Percentage Below $1.90 (2015)" DESC
LIMIT 1;

--Calculate the average PM10 levels ('PM10_(μg/m3)') for each country and year from the 'air_pollution_pm' table. Include only data from 1990 to 2015:
SELECT Country_Name AS
	   Country,
       Year,
       AVG("PM10_(μg/m3)") AS "Average PM10 Level (2010-2015)"
FROM air_pollution_pm
WHERE Year BETWEEN 1990 AND 2015
GROUP BY Country, Year
ORDER BY Country, Year;

-- Find the top 5 countries with the highest indoor air pollution-related deaths ('Indoor_air_pollution_(deaths_per_100,000)') in the year 1990 from the 'death_rates' table. 
SELECT Entity AS Country,
       "Indoor_air_pollution_(deaths_per_100,000)" AS "Indoor Air Pollution Deaths (1990)"
FROM death_rates
WHERE Year = 1990
ORDER BY "Indoor Air Pollution Deaths (1990)" DESC
LIMIT 5;

--Calculate the average manufacturing output for the years 1970 to 2017 for each country in the 'global_top_manufact' table. 
SELECT Country,
       AVG("1970" + "1971" + "1972" + "1973" + "1974" + "1975" + "1976" + "1977" + "1978" + "1979" +
           "1980" + "1981" + "1982" + "1983" + "1984" + "1985" + "1986" + "1987" + "1988" + "1989" +
           "1990" + "1991" + "1992" + "1993" + "1994" + "1995" + "1996" + "1997" + "1998" + "1999" +
           "2000" + "2001" + "2002" + "2003" + "2004" + "2005" + "2006" + "2007" + "2008" + "2009" +
           "2010" + "2011" + "2012" + "2011" + "2012" + "2013" + "2014" + "2015" + "2016" + "2017")
           AS "Average Manufacturing Output (1970-2017)"
FROM global_top_manufact
GROUP BY Country;

--Order the results by the average output in descending order. 
SELECT Country,
       AVG("1970" + "1971" + "1972" + "1973" + "1974" + "1975" + "1976" + "1977" + "1978" + "1979" +
           "1980" + "1981" + "1982" + "1983" + "1984" + "1985" + "1986" + "1987" + "1988" + "1989" +
           "1990" + "1991" + "1992" + "1993" + "1994" + "1995" + "1996" + "1997" + "1998" + "1999" +
           "2000" + "2001" + "2002" + "2003" + "2004" + "2005" + "2006" + "2007" + "2008" + "2009" +
           "2010" + "2011" + "2012" + "2011" + "2012" + "2013" + "2014" + "2015" + "2016" + "2017")
           AS "Average Manufacturing Output (1970-2017)"
FROM global_top_manufact
GROUP BY Country
ORDER BY "Average Manufacturing Output (1970-2017)" DESC;
air_pollution_pm, death_rates, global_top_manufact, poverty_population_distribution

--JOIN queries are used to combine data from multiple tables based on common columns, enabling you to retrieve and analyze data that spans across different aspects or dimensions. 
/*INNER JOIN: An inner join returns only the rows that have matching values in both tables being joined.
This type of join is typically used to combine data that shares a common key.
In this case we can combine air pollution data (air_pollution_pm) with death rates data (death_rates) to analyze the relationship between air pollution and health outcomes.
*/
SELECT ap.Country_Name,
       ap.Year,
       ap."PM2.5_(μg/m3)",
       dr."Air_pollution_(total)_(deaths_per_100,000)"
FROM air_pollution_pm ap
INNER JOIN death_rates dr ON ap.Country_Name = dr.Entity AND ap.Year = dr.Year;
-- In this query, we're joining the air_pollution_pm and death_rates tables based on the Country_Name and Year columns.

/*RIGHT JOIN: A right join returns all rows from the right table and the matching rows from the left table.
If there's no match in the left table, NULL values will be returned for columns from the left table.
This type of join is used to keep all the records from one table and only matching records from the other.
*/
SELECT ppd.Country,
       ppd.Year,
       ppd."below_1.90$_a_day_(World_Bank_(2019))",
       gtm."2000"
FROM poverty_population_distribution ppd
RIGHT JOIN global_top_manufact gtm ON ppd.Country = gtm.Country AND ppd.Year = 2000;
/*RIGHT JOIN made between poverty_population_distribution and global_top_manufact.
We want to keep all records from global_top_manufact for the year 2000 and ONLY matching records from poverty_population_distribution.
If there's no matching data in the poverty table for a specific country, we'll still get the manufacturing data for that country with NULL values for poverty-related columns.
*/

-- ¿Cuántas muertes provocadas por la contaminación del aire total fueron debidas al porcentaje NO2 agrupadas por año en España?
SELECT dr.year, dr.entity, round(dr.'air_pollution_(total)_(deaths_per_100,000)', 2) AS 'Total deaths (x 100.000)', round(ap.'no2_temporal_coverage_(%)', 2) AS '% NO2' 
	from death_rates dr
inner join air_pollution_pm ap
	on ap.year = dr.year
	and ap.country_name = dr.entity
where dr.entity IS 'Spain' AND ap.'no2_temporal_coverage_(%)' != 0  
group by dr.year 

--Alternatively of the previous: 
SELECT dr.year, dr.entity, ROUND(dr."air_pollution_(total)_(deaths_per_100,000)", 2) AS "Total deaths (x 100,000)", ROUND(ap."no2_temporal_coverage_(%)", 2) AS "% NO2"
	FROM death_rates dr
INNER JOIN air_pollution_pm ap
	ON ap.year = dr.year
	AND ap.country_name = dr.entity
WHERE dr.entity = 'Spain' AND ap."no2_temporal_coverage_(%)" != 0
GROUP BY dr.year;

--Suppose I want to update the poverty data in the poverty_population_distribution table for a specific country and year
UPDATE poverty_population_distribution
SET "below_1.90$_a_day_(World_Bank_(2019))" = 2.5,
    "1.9_-_3.20$_a_day_(World_Bank_(2019))" = 5.0
WHERE Country = 'Spain' AND Year = 2001;

--
SELECT *
FROM poverty_population_distribution
WHERE Country = 'Spain' AND Year = 2001;


--We're going to do some class exercises with Ale:

