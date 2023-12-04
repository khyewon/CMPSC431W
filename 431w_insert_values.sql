PRAGMA foreign_keys = ON;

INSERT INTO Countries
SELECT *
FROM Countries_original;

INSERT INTO Regions
SELECT *
FROM Regions_original;

INSERT INTO Airport
SELECT *
FROM Airports_original;

INSERT INTO Frequency
SELECT *
FROM Frequency_original;

INSERT INTO Navaids
SELECT *
FROM Navaids_original;

INSERT INTO Location_Navaids
SELECT *
FROM Location_navaids_original;

INSERT INTO Location_Airport
SELECT *
FROM Location_Airports_original;

INSERT INTO Runways
SELECT *
FROM Runways_original;

SELECT * FROM Runways;