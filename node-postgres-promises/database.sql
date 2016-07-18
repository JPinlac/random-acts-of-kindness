DROP DATABASE IF EXISTS rak;
CREATE DATABASE rak;

\c rak;

CREATE TABLE cards (
	ID 			SERIAL PRIMARY KEY,
	checkIns	INTEGER[]
);

CREATE TABLE checkIn (
	ID 			SERIAL PRIMARY KEY,
	time		TIMESTAMP WITH TIME ZONE default current_timestamp,
	location	DOUBLE PRECISION[],
	userId		INTEGER,
	descriptionProperty TEXT
);

CREATE TABLE users (
	ID 			SERIAL PRIMARY KEY,
	fbUserId	TEXT,
	checkIns	INTEGER[]
);

INSERT INTO cards (checkIns)
	VALUES ('{1}');

INSERT INTO checkIn (location, userId, descriptionProperty)
 	VALUES ('{48.123, -12.122}', 1, 'IT WORKS');

INSERT INTO users (fbUserId)
 	VALUES (1231);
