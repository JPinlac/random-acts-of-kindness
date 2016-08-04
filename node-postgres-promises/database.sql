DROP DATABASE IF EXISTS rak;
CREATE DATABASE rak;
\c rak;

ALTER DATABASE rak SET timezone TO 'America/New_york';

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
	VALUES ('{1,2,3,4,5,6,7,8,9,10}');

INSERT INTO checkIn (location, userId, descriptionProperty)
 	VALUES ('{42.365150, -83.071439}', 1, 'IT WORKS');

INSERT INTO checkIn (location, userId, descriptionProperty)
	VALUES ('{42.365213, -83.072989}', 1, 'AGAIN');

INSERT INTO users (fbUserId)
 	VALUES (1231);
