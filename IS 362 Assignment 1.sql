/* How many airplanes have listed speeds? */
SELECT COUNT(*) 
FROM planes
WHERE speed IS NOT NULL;

/* What is the minimum listed speed and the maximum listed speed? */
SELECT MIN(CAST(speed AS UNSIGNED)) AS min_speed_numeric, 
       MAX(CAST(speed AS UNSIGNED)) AS max_speed_numeric
FROM planes
WHERE speed REGEXP '^[0-9]+$';

/* What is the total distance flown by all of the planes in January 2013? */
SELECT SUM(distance) AS total_distance
FROM flights
WHERE year = 2013 AND month = 1;

/* What is the total distance flown by all of the planes in January 2013 where the tailnum is missing? */
SELECT SUM(distance) AS total_distance
FROM flights
WHERE year = 2013
AND month = 1
AND tailnum IS NULL;

/* What is the total distance flown for all planes on July 5, 2013 grouped by aircraft manufacturer? Write this
statement first using an INNER JOIN */
SELECT manufacturer, SUM(distance) AS total_distance
FROM flights
INNER JOIN planes ON flights.tailnum = planes.tailnum
WHERE flights.year = 2013
AND flights.month = 7
AND flights.day= 5
GROUP BY manufacturer;

/* What is the total distance flown for all planes on July 5,
2013 grouped by aircraft manufacturer? Write this statement using a LEFT OUTER JOIN */
SELECT planes.manufacturer, SUM(flights.distance) AS total_distance
FROM flights
LEFT OUTER JOIN planes ON flights.tailnum = planes.tailnum
WHERE flights.year= 2013
AND flights.month = 7
AND flights.day = 5
GROUP BY planes.manufacturer;

/* The difference between inner join and outer join is that outer join includes all results even if there is no
manufacturer that has a specific distance. Inner join only lists manufacturers that have a designed distance. */

/* Can you construct a query that combines data from the `flights`, `planes`, and `weather` tables in the flights database
 providing details about flights, aircraft, and weather conditions? */

SELECT *
FROM flights
INNER JOIN planes ON flights.tailnum = planes.tailnum
INNER JOIN weather ON flights.origin = weather.origin
WHERE flights.year = 2013 AND flights.month = 5 AND flights.day = 23;
