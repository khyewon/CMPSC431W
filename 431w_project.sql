/* Update data */
UPDATE Countries SET continent = 'North America' WHERE continent = 'NA';

/* How many opened airports in the USA - counting */
SELECT COUNT(id) AS USAairports
FROM Airport
WHERE countries_code = 'US'
	AND airport_type <> 'closed';

/* How many large airports in the USA - filtering */
SELECT COUNT(id) AS largeUSAairports
FROM Airport
WHERE countries_code = 'US'
	AND airport_type = 'large_airport';
	
/* Show countries and airport name by ascending order of country name */
SELECT C.name AS CountryName, A.name AS AirportName
FROM Airport A JOIN Countries C ON A.countries_code = C.code
ORDER BY C.name;

/* The continent with the largest number of airports - Aggregation Query */
SELECT c.continent, COUNT(a.id) AS airport_count
FROM Airport a
JOIN Countries c ON a.countries_code = c.code
GROUP BY c.continent
ORDER BY airport_count DESC
LIMIT 1;

/* Find the frequency and name of the airport with the shortest runway, as well as its exact location (latitude and longitude) and the name of the country where the airport is located. - JOIN five tables */
SELECT DISTINCT A.name AS AirportName,
				R.length_ft AS ShortestRunway,
				F.frequency_mhz AS Frequency,
				L.latitude AS Latitude,
				L.longitude AS Longitude,
				C.name AS CountryName
FROM Airport A
	INNER JOIN Countries C ON A.countries_code = C.code
	INNER JOIN Location_Airport L ON A.id = L.airport_id
	INNER JOIN Frequency F ON A.id = F.airport_id
	INNER JOIN Runways R ON A.id = R.airport_id
WHERE R.length_ft = (SELECT MIN(length_ft) FROM Runways WHERE length_ft > 0);