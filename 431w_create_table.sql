CREATE TABLE Countries (
    number INT NOT NULL,
    code CHAR(2) NOT NULL,
    name VARCHAR(255) NOT NULL,
    continent VARCHAR(255) NOT NULL,
    PRIMARY KEY (number, code)
);

CREATE TABLE Regions (
    id INT PRIMARY KEY,
    code VARCHAR(10) NOT NULL,
    name VARCHAR(255) NOT NULL,
    countries_code CHAR(2) NOT NULL,
    FOREIGN KEY (countries_code) REFERENCES Countries(code)
);

CREATE TABLE Airport (
    id INT PRIMARY KEY,
    ident VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    airport_type VARCHAR(50) NOT NULL,
    countries_code CHAR(2) NOT NULL,
    regions_code VARCHAR(10) NOT NULL,
    gps_code VARCHAR(255) NOT NULL,
    FOREIGN KEY (countries_code) REFERENCES Countries(code),
    FOREIGN KEY (regions_code) REFERENCES Regions(code)
);

CREATE TABLE Frequency (
    id INT PRIMARY KEY,
    airport_id INT NOT NULL,
    type VARCHAR(50) NOT NULL,
    frequency_mhz DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (airport_id) REFERENCES airport(id)
);

CREATE TABLE Navaids (
    id INT PRIMARY KEY,
    filename VARCHAR(255) NOT NULL,
    ident VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    countries_code CHAR(2) NOT NULL,
    FOREIGN KEY (countries_code) REFERENCES Countries(code)
);

CREATE TABLE Location_Airport (
    latitude DECIMAL(9, 6) NOT NULL,
    longitude DECIMAL(9, 6) NOT NULL,
    elevation DECIMAL(10, 2) NOT NULL,
    airport_id INT NOT NULL,
    PRIMARY KEY (latitude, longitude, elevation),
    FOREIGN KEY (airport_id) REFERENCES airport(id)
);

CREATE TABLE Location_Navaids (
    latitude DECIMAL(9, 6) NOT NULL,
    longitude DECIMAL(9, 6) NOT NULL,
    elevation DECIMAL(10, 2) NOT NULL,
    navaid_id INT NOT NULL,
    PRIMARY KEY (latitude, longitude, elevation),
    FOREIGN KEY (navaid_id) REFERENCES Navaids(id)
);

CREATE TABLE Runways (
    id INT PRIMARY KEY,
    airport_id INT NOT NULL,
    length_ft INT NOT NULL,
    wide_ft INT NOT NULL,
    FOREIGN KEY (airport_id) REFERENCES airport(id)
);
