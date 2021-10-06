--Highest Energy Consumption
--Find the date with the highest total energy consumption from the Facebook data centers. 
--Output the date along with the total energy consumption across all data centers.


WITH asia as (SELECT *, 'asia' AS region FROM
FB_ASIA_ENERGY),
eu as (SELECT *, 'eu' AS region FROM
FB_EU_ENERGY),
na as (SELECT *, 'na' AS region FROM
FB_NA_ENERGY),

global_dates as (
SELECT date FROM
ASIA

UNION 
SELECT date FROM
EU
UNION 
SELECT date FROM
NA),

--coalesce to get replace NaNs with 0's 
global as (SELECT g.date, coalesce(a.consumption,0) as asia_consumption, 
 coalesce(e.consumption, 0) as eu_consumption, 
 coalesce(na.consumption, 0) as na_consumption,
 coalesce(a.consumption,0) + coalesce(e.consumption,0) + coalesce(na.consumption,0) as total_energy

FROM global_dates AS g
LEFT JOIN asia AS a
ON g.date = a.date
LEFT JOIN eu AS e
ON g.date = e.date
LEFT JOIN na AS na
ON g.date = na.date)

SELECT date, total_energy

FROM(
SELECT date, total_energy, dense_rank() over (order by total_energy desc)
FROM global) as final
WHERE dense_rank = 1





--SELECT region, MAX(consumption)
--FROM global
--GROUP BY region
--ORDER BY 2 DESC
