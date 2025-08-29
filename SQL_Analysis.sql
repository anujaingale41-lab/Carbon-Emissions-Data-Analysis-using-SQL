1.Which year has maximum emissions?
SELECT year, SUM(total_emissions_Mtco2e) AS total_emissions
FROM emissions_low_granularity
GROUP BY year
ORDER BY total_emissions DESC
LIMIT 1;

2.Which year has maximum emissions by which parent entity?
SELECT year, parent_entity,SUM(total_emissions_Mtco2e) AS total_emissions
FROM emissions_low_granularity
GROUP BY year, parent_entity
ORDER BY total_emissions DESC
LIMIT 1;

3.Which one was the top emitter by parent name and parent entity?
SELECT parent_entity,parent_type, SUM(total_emissions_Mtco2e) AS emissions
FROM emissions_low_granularity
GROUP BY parent_entity, parent_type 
ORDER BY emissions DESC;

4.What are year on year change in emissions?
SELECT year, parent_entity, parent_type,total_emissions_Mtco2e,
LAG(total_emissions_Mtco2e) OVER (PARTITION BY parent_entity ORDER BY year) AS previous_year_emissions,
total_emissions_Mtco2e - LAG(total_emissions_Mtco2e) OVER (PARTITION BY parent_entity ORDER BY year) AS emission_change
FROM emissions_low_granularity
WHERE total_emissions_Mtco2e IS NOT NULL;

5.What are the average emissions per parent name?
SELECT parent_entity, AVG(total_emissions_Mtco2e) AS avg_emissions
FROM emissions_low_granularity
GROUP BY parent_entity;

6.Parent name by with extremely high emissions arranged in descending order?
SELECT * FROM emissions_low_granularity
WHERE total_emissions_Mtco2e > 1000 OR total_emissions_Mtco2e < 10
ORDER BY total_emissions_Mtco2e DESC ;

7.What are the emissions before and after 2015?
SELECT parent_entity,
SUM(CASE WHEN year < 2015 THEN total_emissions_Mtco2e ELSE 0 END) AS emissions_before_2015,
SUM(CASE WHEN year >= 2015 THEN total_emissions_Mtco2e ELSE 0 END) AS emissions_after_2015
FROM emissions_low_granularity
GROUP BY parent_entity;

8.Which are the top polluters by parent type?
SELECT parent_type, parent_entity, SUM(total_emissions_Mtco2e) AS total_emissions
FROM emissions_low_granularity
GROUP BY parent_type, parent_entity
ORDER BY total_emissions DESC
LIMIT 10;

9.Which parent entity has reduced emissions over time ?
SELECT parent_entity,year,ROUND(prev_year_emissions - total_emissions_Mtco2e, 2) AS reduction
FROM EmissionDiff
WHERE prev_year_emissions IS NOT NULL AND total_emissions_Mtco2e < prev_year_emissions;

10.What are parent type wise emission trend over time?
SELECT parent_type, year, SUM(total_emissions_Mtco2e) AS sector_emissions
FROM emissions_low_granularity
GROUP BY parent_type, year
ORDER BY parent_type, year;

11.Which parent entity have most improved Emissions Reduction?
WITH YearlyChange AS (
  SELECT parent_entity, year,
         total_emissions_Mtco2e,
         LAG(total_emissions_Mtco2e) OVER (PARTITION BY parent_entity ORDER BY year) AS prev_year_emissions
  FROM emissions_low_granularity
)
SELECT parent_entity, 
       ROUND(prev_year_emissions - total_emissions_Mtco2e, 2) AS reduction
FROM YearlyChange
WHERE prev_year_emissions IS NOT NULL
ORDER BY reduction DESC
LIMIT 10;




