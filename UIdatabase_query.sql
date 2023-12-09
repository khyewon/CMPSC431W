CREATE TABLE Countries (
	number INTEGER NOT NULL,
	code CHAR(2) NOT NULL,
	name VARCHAR(255) NOT NULL,
	continent VARCHAR(255) NOT NULL,
	PRIMARY KEY (code)
	);
	
CREATE INDEX idx_countries_code ON Countries(code);
	
INSERT INTO Countries
SELECT *
FROM Countries_original;


	
CREATE TABLE Regions (
	id INTEGER NOT NULL,
	code VARCHAR(10) NOT NULL,
	name VARCHAR(255) NOT NULL,
	countries_code CHAR(2) NOT NULL,
	PRIMARY KEY (id),
	CONSTRAINT FK_countryCode FOREIGN KEY (countries_code) REFERENCES Countries(code) ON UPDATE CASCADE ON DELETE CASCADE
	);

CREATE INDEX idx_regions_code ON Regions(code);

INSERT INTO Regions
SELECT *
FROM Regions_original;



CREATE TABLE Airport (
	id INTEGER NOT NULL,
	ident VARCHAR(255) NOT NULL,
	name VARCHAR(255) NOT NULL,
	airport_type VARCHAR(50) NOT NULL,
	countries_code CHAR(2) NOT NULL,
	regions_code VARCHAR(10) NOT NULL,
	gps_code VARCHAR(255),
	PRIMARY KEY (id),
	CONSTRAINT FK_countryCodeAir FOREIGN KEY (countries_code) REFERENCES Countries(code) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT FK_regionCode FOREIGN KEY (regions_code) REFERENCES Regions(code) ON UPDATE CASCADE ON DELETE CASCADE
	);

CREATE INDEX idx_airport_id_code ON Airport(id);
CREATE INDEX idx_airport_countries_code ON Airport(countries_code);
CREATE INDEX idx_airport_regions_code ON Airport(regions_code);

INSERT INTO Airport
SELECT *
FROM Airports_original;



CREATE TABLE Frequency (
	id INTEGER NOT NULL,
	airport_id INTEGER NOT NULL,
	type VARCHAR(50) NOT NULL,
	frequency_mhz DECIMAL(10, 2) NOT NULL,
	PRIMARY KEY (id),
	CONSTRAINT FK_airportID FOREIGN KEY (airport_id) REFERENCES Airport(id) ON UPDATE CASCADE ON DELETE CASCADE
	);

INSERT INTO Frequency
SELECT *
FROM Frequency_original;



CREATE TABLE Navaids (
	id INTEGER NOT NULL,
	filename VARCHAR(255) NOT NULL,
	ident VARCHAR(255) NOT NULL,
	name VARCHAR(255) NOT NULL,
	countries_code CHAR(2) NOT NULL,
	PRIMARY KEY (id),
	CONSTRAINT FK_countryCode FOREIGN KEY (countries_code) REFERENCES Countries(code) ON UPDATE CASCADE ON DELETE CASCADE
	);
	
CREATE INDEX idx_navaids_id ON Navaids(id);
	
INSERT INTO Navaids
SELECT *
FROM Navaids_original;


	
CREATE TABLE Location_Airport (
	latitude DECIMAL(9, 6) NOT NULL,
	longitude DECIMAL(9, 6) NOT NULL,
	elevation DECIMAL(10, 2),
	airport_id INTEGER NOT NULL,
	PRIMARY KEY (latitude, longitude, airport_id),
	CONSTRAINT FK_airportID FOREIGN KEY (airport_id) REFERENCES Airport(id) ON UPDATE CASCADE ON DELETE CASCADE
	);
	
INSERT INTO Location_Navaids
SELECT *
FROM Location_navaids_original;



CREATE TABLE Location_Navaids (
	latitude DECIMAL(9, 6) NOT NULL,
	longitude DECIMAL(9, 6) NOT NULL,
	elevation DECIMAL(10, 2),
	navaid_id INTEGER NOT NULL,
	PRIMARY KEY (latitude, longitude, navaid_id),
	CONSTRAINT FK_navaidsID FOREIGN KEY (navaid_id) REFERENCES Navaids(id) ON UPDATE CASCADE ON DELETE CASCADE
	);
	
INSERT INTO Location_Airport
SELECT *
FROM Location_Airports_original;


	
CREATE TABLE Runways (
	id INTEGER NOT NULL,
	airport_id INTEGER NOT NULL,
	length_ft INTEGER,
	wide_ft INTEGER,
	PRIMARY KEY (id),
	CONSTRAINT FK_airportID FOREIGN KEY (airport_id) REFERENCES Airport(id) ON UPDATE CASCADE ON DELETE CASCADE
	);

INSERT INTO Runways
SELECT *
FROM Runways_original;


DROP TABLE Airports_original;
DROP TABLE Countries_original;
DROP TABLE Frequency_original;
DROP TABLE Location_Airports_original;
DROP TABLE Location_navaids_original;
DROP TABLE Navaids_original;
DROP TABLE Regions_original;
DROP TABLE Runways_original;


UPDATE Countries SET continent = 'North America' WHERE continent = 'NA';
