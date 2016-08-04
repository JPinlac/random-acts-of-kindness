DROP DATABASE IF EXISTS rak;
CREATE DATABASE rak;
\c rak;

ALTER DATABASE rak SET timezone TO 'America/New_york';

CREATE TABLE checkIn (
	ID 			SERIAL PRIMARY KEY,
	time		TIMESTAMP WITH TIME ZONE default current_timestamp,
	location	DOUBLE PRECISION[],
	userId		TEXT,
	descriptionProperty TEXT,
	card		INTEGER
);

CREATE TABLE users (
	ID 			SERIAL PRIMARY KEY,
	fbUserId	TEXT,
	username	TEXT
);

INSERT INTO checkIn (location, userId, descriptionProperty, card)
 	VALUES ('{42.365150, -83.071439}', 42, 'IT WORKS', 1);

INSERT INTO checkIn (location, userId, descriptionProperty, card)
	VALUES ('{42.365213, -83.072989}', 42, 'AGAIN', 1);

INSERT INTO users (fbUserId,username)
 	VALUES (42, 'Patrick Star');
