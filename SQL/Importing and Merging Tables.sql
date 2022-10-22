/*
 Importing data from October 2021
 */
CREATE TABLE trip_data_2021_10 (
	ride_id varchar(16),
	rideable_type varchar(13),
	started_at timestamp NOT NULL, 
	ended_at timestamp NOT NULL,
	start_station_name varchar(128),
	start_station_id varchar(128),
	end_station_name varchar(128),
	end_station_id varchar(128),
	start_lat float,
	start_lng float,
	end_lat float,
	end_lng float,
	member_casual varchar(13)
);


COPY trip_data_2021_10 
FROM 'C:\Users\mkcle\Desktop\Coursera\Google Data Analytics\Capstone Project\data\project_1\data\202110-divvy-tripdata.csv'
WITH (FORMAT CSV, HEADER);

SELECT * FROM trip_data_2021_10 LIMIT 50;

----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------

/*
 Importing data from November 2021
 */
CREATE TABLE trip_data_2021_11 (
	ride_id varchar(16),
	rideable_type varchar(13),
	started_at timestamp NOT NULL, 
	ended_at timestamp NOT NULL,
	start_station_name varchar(128),
	start_station_id varchar(128),
	end_station_name varchar(128),
	end_station_id varchar(128),
	start_lat float,
	start_lng float,
	end_lat float,
	end_lng float,
	member_casual varchar(13)
);

COPY trip_data_2021_11 
FROM 'C:\Users\mkcle\Desktop\Coursera\Google Data Analytics\Capstone Project\data\project_1\data\202111-divvy-tripdata.csv'
WITH (FORMAT CSV, HEADER);

SELECT * FROM trip_data_2021_11 LIMIT 50;

----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------

/*
 Importing data from December 2021
 */
CREATE TABLE trip_data_2021_12 (
	ride_id varchar(16),
	rideable_type varchar(13),
	started_at timestamp NOT NULL, 
	ended_at timestamp NOT NULL,
	start_station_name varchar(128),
	start_station_id varchar(128),
	end_station_name varchar(128),
	end_station_id varchar(128),
	start_lat float,
	start_lng float,
	end_lat float,
	end_lng float,
	member_casual varchar(13)
);

COPY trip_data_2021_12 
FROM 'C:\Users\mkcle\Desktop\Coursera\Google Data Analytics\Capstone Project\data\project_1\data\202112-divvy-tripdata.csv'
WITH (FORMAT CSV, HEADER);

SELECT * FROM trip_data_2021_12 LIMIT 50;

----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------

/*
 Importing data from December 2021
 */
CREATE TABLE trip_data_2021_12 (
	ride_id varchar(16),
	rideable_type varchar(13),
	started_at timestamp NOT NULL, 
	ended_at timestamp NOT NULL,
	start_station_name varchar(128),
	start_station_id varchar(128),
	end_station_name varchar(128),
	end_station_id varchar(128),
	start_lat float,
	start_lng float,
	end_lat float,
	end_lng float,
	member_casual varchar(13)
);

COPY trip_data_2021_12 
FROM 'C:\Users\mkcle\Desktop\Coursera\Google Data Analytics\Capstone Project\data\project_1\data\202112-divvy-tripdata.csv'
WITH (FORMAT CSV, HEADER);

SELECT * FROM trip_data_2021_12 LIMIT 50;

----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------

/*
 Importing data from January 2022
 */
CREATE TABLE trip_data_2022_01 (
	ride_id varchar(16),
	rideable_type varchar(13),
	started_at timestamp NOT NULL, 
	ended_at timestamp NOT NULL,
	start_station_name varchar(128),
	start_station_id varchar(128),
	end_station_name varchar(128),
	end_station_id varchar(128),
	start_lat float,
	start_lng float,
	end_lat float,
	end_lng float,
	member_casual varchar(13)
);

COPY trip_data_2022_01 
FROM 'C:\Users\mkcle\Desktop\Coursera\Google Data Analytics\Capstone Project\data\project_1\data\202201-divvy-tripdata.csv'
WITH (FORMAT CSV, HEADER);

SELECT * FROM trip_data_2022_01 LIMIT 50;

----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------

/*
 Importing data from February 2022
 */
CREATE TABLE trip_data_2022_02 (
	ride_id varchar(16),
	rideable_type varchar(13),
	started_at timestamp NOT NULL, 
	ended_at timestamp NOT NULL,
	start_station_name varchar(128),
	start_station_id varchar(128),
	end_station_name varchar(128),
	end_station_id varchar(128),
	start_lat float,
	start_lng float,
	end_lat float,
	end_lng float,
	member_casual varchar(13)
);

COPY trip_data_2022_02 
FROM 'C:\Users\mkcle\Desktop\Coursera\Google Data Analytics\Capstone Project\data\project_1\data\202202-divvy-tripdata.csv'
WITH (FORMAT CSV, HEADER);

SELECT * FROM trip_data_2022_02 LIMIT 50;

----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------


/*
 Importing data from March 2022
 */
CREATE TABLE trip_data_2022_03 (
	ride_id varchar(16),
	rideable_type varchar(13),
	started_at timestamp NOT NULL, 
	ended_at timestamp NOT NULL,
	start_station_name varchar(128),
	start_station_id varchar(128),
	end_station_name varchar(128),
	end_station_id varchar(128),
	start_lat float,
	start_lng float,
	end_lat float,
	end_lng float,
	member_casual varchar(13)
);

COPY trip_data_2022_03 
FROM 'C:\Users\mkcle\Desktop\Coursera\Google Data Analytics\Capstone Project\data\project_1\data\202203-divvy-tripdata.csv'
WITH (FORMAT CSV, HEADER);

SELECT * FROM trip_data_2022_03 LIMIT 50;

----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------

/*
 Importing data from April 2022
 */
CREATE TABLE trip_data_2022_04 (
	ride_id varchar(16),
	rideable_type varchar(13),
	started_at timestamp NOT NULL, 
	ended_at timestamp NOT NULL,
	start_station_name varchar(128),
	start_station_id varchar(128),
	end_station_name varchar(128),
	end_station_id varchar(128),
	start_lat float,
	start_lng float,
	end_lat float,
	end_lng float,
	member_casual varchar(13)
);

COPY trip_data_2022_04 
FROM 'C:\Users\mkcle\Desktop\Coursera\Google Data Analytics\Capstone Project\data\project_1\data\202204-divvy-tripdata.csv'
WITH (FORMAT CSV, HEADER);

SELECT * FROM trip_data_2022_04 LIMIT 50;

----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------

/*
 Importing data from May 2022
 */
CREATE TABLE trip_data_2022_05 (
	ride_id varchar(16),
	rideable_type varchar(13),
	started_at timestamp NOT NULL, 
	ended_at timestamp NOT NULL,
	start_station_name varchar(128),
	start_station_id varchar(128),
	end_station_name varchar(128),
	end_station_id varchar(128),
	start_lat float,
	start_lng float,
	end_lat float,
	end_lng float,
	member_casual varchar(13)
);

COPY trip_data_2022_05 
FROM 'C:\Users\mkcle\Desktop\Coursera\Google Data Analytics\Capstone Project\data\project_1\data\202205-divvy-tripdata.csv'
WITH (FORMAT CSV, HEADER);

SELECT * FROM trip_data_2022_05 LIMIT 50;

----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------

/*
 Importing data from June 2022
 */
CREATE TABLE trip_data_2022_06 (
	ride_id varchar(16),
	rideable_type varchar(13),
	started_at timestamp NOT NULL, 
	ended_at timestamp NOT NULL,
	start_station_name varchar(128),
	start_station_id varchar(128),
	end_station_name varchar(128),
	end_station_id varchar(128),
	start_lat float,
	start_lng float,
	end_lat float,
	end_lng float,
	member_casual varchar(13)
);

COPY trip_data_2022_06 
FROM 'C:\Users\mkcle\Desktop\Coursera\Google Data Analytics\Capstone Project\data\project_1\data\202206-divvy-tripdata.csv'
WITH (FORMAT CSV, HEADER);

SELECT * FROM trip_data_2022_06 LIMIT 50;

----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------

/*
 Importing data from July 2022
 */
CREATE TABLE trip_data_2022_07 (
	ride_id varchar(16),
	rideable_type varchar(13),
	started_at timestamp NOT NULL, 
	ended_at timestamp NOT NULL,
	start_station_name varchar(128),
	start_station_id varchar(128),
	end_station_name varchar(128),
	end_station_id varchar(128),
	start_lat float,
	start_lng float,
	end_lat float,
	end_lng float,
	member_casual varchar(13)
);

COPY trip_data_2022_07 
FROM 'C:\Users\mkcle\Desktop\Coursera\Google Data Analytics\Capstone Project\data\project_1\data\202207-divvy-tripdata.csv'
WITH (FORMAT CSV, HEADER);

SELECT * FROM trip_data_2022_07 LIMIT 50;

----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------

/*
 Importing data from August 2022
 */
CREATE TABLE trip_data_2022_08 (
	ride_id varchar(16),
	rideable_type varchar(13),
	started_at timestamp NOT NULL, 
	ended_at timestamp NOT NULL,
	start_station_name varchar(128),
	start_station_id varchar(128),
	end_station_name varchar(128),
	end_station_id varchar(128),
	start_lat float,
	start_lng float,
	end_lat float,
	end_lng float,
	member_casual varchar(13)
);

COPY trip_data_2022_08 
FROM 'C:\Users\mkcle\Desktop\Coursera\Google Data Analytics\Capstone Project\data\project_1\data\202208-divvy-tripdata.csv'
WITH (FORMAT CSV, HEADER);

SELECT * FROM trip_data_2022_08 LIMIT 50;

----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------

/*
 Importing data from September 2022
 */
CREATE TABLE trip_data_2022_09 (
	ride_id varchar(16),
	rideable_type varchar(13),
	started_at timestamp NOT NULL, 
	ended_at timestamp NOT NULL,
	start_station_name varchar(128),
	start_station_id varchar(128),
	end_station_name varchar(128),
	end_station_id varchar(128),
	start_lat float,
	start_lng float,
	end_lat float,
	end_lng float,
	member_casual varchar(13)
);

COPY trip_data_2022_09 
FROM 'C:\Users\mkcle\Desktop\Coursera\Google Data Analytics\Capstone Project\data\project_1\data\202209-divvy-publictripdata.csv'
WITH (FORMAT CSV, HEADER);

SELECT * FROM trip_data_2022_09 LIMIT 50;

----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------

/*
 Merging all the tables into one
 */

CREATE TABLE trip_data_past_year AS (
	SELECT * FROM trip_data_2021_10
UNION
	SELECT * FROM trip_data_2021_11 
UNION
	SELECT * FROM trip_data_2021_12 
UNION 
	SELECT * FROM trip_data_2022_01 
UNION
	SELECT * FROM trip_data_2022_02 
UNION
	SELECT * FROM trip_data_2022_03
UNION
	SELECT * FROM trip_data_2022_04
UNION
	SELECT * FROM trip_data_2022_05
UNION
	SELECT * FROM trip_data_2022_06
UNION
	SELECT * FROM trip_data_2022_07
UNION
	SELECT * FROM trip_data_2022_08
UNION
	SELECT * FROM trip_data_2022_09
);

SELECT count(*) FROM trip_data_past_year;
-- There is a total of 5,828,235 rows in the merged dataset

-- Check if we didn't miss any information while merging the tables
SELECT sum(cnt.count) FROM 
(SELECT count(*) FROM trip_data_2021_10
UNION ALL 
SELECT count(*) FROM trip_data_2021_11 
UNION ALL 
SELECT count(*) FROM trip_data_2021_12 
UNION ALL  
SELECT count(*) FROM trip_data_2022_01
UNION ALL  
SELECT count(*) FROM trip_data_2022_02 
UNION ALL 
SELECT count(*) FROM trip_data_2022_03
UNION ALL 
SELECT count(*) FROM trip_data_2022_04
UNION ALL 
SELECT count(*) FROM trip_data_2022_05
UNION ALL 
SELECT count(*) FROM trip_data_2022_06
UNION ALL 
SELECT count(*) FROM trip_data_2022_07
UNION ALL 
SELECT count(*) FROM trip_data_2022_08
UNION ALL 
SELECT count(*) FROM trip_data_2022_09) AS cnt;

-- The query above gives us the same answer: 5,828,235



/*
dropting all the tables exept the one merged
 */
DROP TABLE trip_data_2021_10;
DROP TABLE trip_data_2021_11;
DROP TABLE trip_data_2021_12;
DROP TABLE trip_data_2022_01;
DROP TABLE trip_data_2022_02;
DROP TABLE trip_data_2022_03;
DROP TABLE trip_data_2022_04;
DROP TABLE trip_data_2022_05;
DROP TABLE trip_data_2022_06;
DROP TABLE trip_data_2022_07;
DROP TABLE trip_data_2022_08;
DROP TABLE trip_data_2022_09;