---------------------------------------------------------------------
---------------   NORMALIZING THE DATA    ---------------------------
---------------------------------------------------------------------

-- checking how many unique values each column has. 
-- The total number of rows is 5,828,235
SELECT 
	count(DISTINCT trim(ride_id)) AS count_ride_id,
	count(DISTINCT trim(rideable_type)) AS count_rideable_type,
	count(DISTINCT trim(start_station_name)) AS count_start_station_name,
	count(DISTINCT trim(start_station_id)) AS count_start_station_id,
	count(DISTINCT trim(end_station_name)) AS count_end_station_name,
	count(DISTINCT trim(end_station_id)) AS count_end_station_id,
	count(DISTINCT start_lat) AS count_start_lat,
	count(DISTINCT start_lng) AS count_start_lng,
	count(DISTINCT end_lat) AS count_end_lat,
	count(DISTINCT end_lng) AS count_end_lng,
	count(DISTINCT trim(member_casual)) AS count_member_casual
FROM trip_data_past_year; 

/*
 Result (number of uniwue values for each column):
	1. ride_id - 5,828,235
  	2. rideable_type - 3
  	3. start_station_name - 1,591
  	4. start_station_id - 1,302
  	5. end_station_name - 1,609 
  	6. end_station_id - 1,309
  	7. start_lat - 601,242
  	8. start_lng - 569,539
  	9. end_lat - 217,896
  	10. end_lng - 207,376
  	11. member_casual - 2
 */

--------------------------------------------------------------
---------------   rideable_type    ---------------------------
--------------------------------------------------------------
SELECT * FROM trip_data_past_year LIMIT 10;
/*
Creating a table `bikes`
 */
CREATE TABLE bikes (
	id serial,
	bike_type varchar(13) UNIQUE, 
	PRIMARY KEY(id)
);

-- inserting values into the `bike` table
INSERT INTO bikes (bike_type)
SELECT DISTINCT rideable_type
FROM trip_data_past_year;

-- creating column `bike_type_id` in table `trip_data_past_year`
ALTER TABLE trip_data_past_year 
	ADD COLUMN bike_type_id integer
	REFERENCES bikes(id) ON DELETE CASCADE;

-- inserting keys into `bike_type_id` column 
UPDATE trip_data_past_year 
SET bike_type_id = id 
FROM bikes 
WHERE trip_data_past_year.rideable_type = bikes.bike_type;

-- removing `rideable_type` column from trip_data_past_year
ALTER TABLE trip_data_past_year DROP COLUMN rideable_type;

--------------------------------------------------------------
---------------   stations_name    ---------------------------
--------------------------------------------------------------

/*
 I assume columns `start_station_name` and `end_station_name`
 have similar values.
 
 To do: 
 1. Checking for values that don't appear in both columns
 2. Make sure there are no empty spaces at the start and end of the string
*/
	
SELECT 
	DISTINCT trim(start_station_name)
FROM 
	trip_data_past_year 
WHERE 
	start_station_name IS NOT NULL 
AND 
	trim(start_station_name) NOT IN (
		SELECT 
			DISTINCT trim(end_station_name)
		FROM 
			trip_data_past_year  
		WHERE 
			end_station_name IS NOT NULL )
UNION  
SELECT 
	DISTINCT trim(end_station_name)
FROM 
	trip_data_past_year 
WHERE 
	end_station_name IS NOT NULL 
AND 
	trim(end_station_name) NOT IN (
		SELECT 
			DISTINCT trim(start_station_name)
		FROM 
			trip_data_past_year  
		WHERE 
			start_station_name IS NOT NULL);
	
/*   
 Result: there are 58 stations that don't apear in both columns 
  
 Things to do:
 	1. Create a table `station_names` for both start and end stations
 	2. Import values into the `station_names` table
 	3. Create new columns in `trip_data_past_year` table:
 		* `start_station_name_id`
 		* `end_station_name_id`
 	4. Insert KEYS
 	5. Drop columns `start_station_name` and `end_station_name`
 */

-- 1. creating the table `station_names`
CREATE TABLE station_names( 
	id serial,
	station_name varchar(128) UNIQUE,
	PRIMARY KEY(id)
);


-- 2. inserting values into `station_names`
INSERT INTO station_names (station_name)
SELECT 
	DISTINCT start_station_name 
FROM 
	trip_data_past_year 
WHERE start_station_name IS NOT NULL 
UNION 
SELECT 
	DISTINCT end_station_name 
FROM 
	trip_data_past_year 
WHERE end_station_name IS NOT NULL;


-- 3. create new columns in `trip_data_past_year` table:
-- 		* `start_station_name_id`
-- 		* `end_station_name_id`
ALTER TABLE trip_data_past_year 
	ADD COLUMN start_station_name_id integer
		REFERENCES station_names(id) ON DELETE CASCADE,
	ADD COLUMN end_station_name_id integer
		REFERENCES station_names(id) ON DELETE CASCADE;
	
-- 4. inserting KEYS

-- start_station_name_id
UPDATE trip_data_past_year
SET start_station_name_id = id 
FROM station_names 
WHERE trip_data_past_year.start_station_name = station_names.station_name; 

-- checking is all is good
SELECT 
	t.start_station_name,
	s.station_name
FROM 
	trip_data_past_year t
	JOIN station_names s 
	ON t.start_station_name_id = s.id
WHERE t.start_station_name != s.station_name;

-- end_station_name_id
UPDATE trip_data_past_year
SET end_station_name_id = id 
FROM station_names 
WHERE trip_data_past_year.end_station_name = station_names.station_name; 

-- checking if all is good
SELECT 
	t.start_station_name,
	s.station_name
FROM 
	trip_data_past_year t
	JOIN station_names s 
	ON t.start_station_name_id = s.id
WHERE t.start_station_name != s.station_name;


-- 5. drop columns `start_station_name` and `end_station_name`
ALTER TABLE trip_data_past_year 
	DROP COLUMN start_station_name,
	DROP COLUMN end_station_name;


-----------------------------------------------------------
---------------   station_id    ---------------------------
-----------------------------------------------------------

/*
 I have a strong feeling that columns `start_station_name` and 
 `end_station_name` also have similar values.
 
 To do: 
 1. Checking for values that don't appear in both columns
 2. Make sure there are no empty spaces at the start and end of the string
*/
SELECT 
	DISTINCT trim(start_station_id)
FROM 
	trip_data_past_year 
WHERE 
	start_station_id IS NOT NULL 
AND 
	trim(start_station_id) NOT IN (
		SELECT 
			DISTINCT trim(end_station_id)
		FROM 
			trip_data_past_year  
		WHERE 
			end_station_id IS NOT NULL )
UNION  
SELECT 
	DISTINCT trim(end_station_id)
FROM 
	trip_data_past_year 
WHERE 
	end_station_id IS NOT NULL 
AND 
	trim(end_station_id) NOT IN (
		SELECT 
			DISTINCT trim(start_station_id)
		FROM 
			trip_data_past_year  
		WHERE 
			start_station_id IS NOT NULL);

/*
 Result: there are 19 values that don't appear in both columns.
 Regardless I decided to drop the `start_station_name` and 
 `end_station_name` because:
 	* 1. I have the names of the stations and the geo-locations.
 	* 2. Make my computers life easier. 
 */
ALTER TABLE trip_data_past_year 
	DROP COLUMN start_station_id,
	DROP COLUMN end_station_id; 
		

-----------------------------------------------------------
---------------   member_casual    ------------------------
-----------------------------------------------------------

/*
 The column `member_casual` has 2 unique values, member and casual.
 
 Things to do:
 	1. Create a table `member_types` 
 	2. Import values into the `member_types` table
 	3. Create new column in `trip_data_past_year` table:
 		* `member_type_id`
 	4. Insert KEYS
 	5. Drop column `member_casual` 
 */

-- 1. Create a table `member_types`
CREATE TABLE member_types (
	id serial,
	member_type varchar(6) UNIQUE,
	PRIMARY KEY(id)
);

-- 2. Import values into the `member_types` table
INSERT INTO member_types (member_type)
SELECT DISTINCT member_casual
FROM trip_data_past_year; 


-- 3. Create new column in `trip_data_past_year` table:
-- 		* `member_type_id`
ALTER TABLE trip_data_past_year 
	ADD COLUMN member_type_id integer
	REFERENCES member_types(id) ON DELETE CASCADE;

-- 4. Insert KEYS
UPDATE trip_data_past_year 
SET member_type_id = id 
FROM member_types 
WHERE trip_data_past_year.member_casual = member_types.member_type;

-- check
SELECT 
	t.member_casual,
	m.member_type
FROM 
	trip_data_past_year t
	JOIN member_types m 
		ON t.member_type_id = m.id
WHERE t.member_casual != m.member_type;

-- 5. Drop column `member_casual` 
ALTER TABLE trip_data_past_year 
	DROP COLUMN member_casual;



-----------------------------------------------------------
--------------- Connect all the tables --------------------
-----------------------------------------------------------

SELECT 
	ride_id,
	m.member_type,
	b.bike_type,
	s1.station_name AS start_station_name,
	s2.station_name AS end_station_name,
	started_at,
	ended_at,
	start_lat,
	start_lng,
	end_lat,
	end_lng	
FROM 
	trip_data_past_year t
	JOIN bikes b 
		ON t.bike_type_id = b.id 
	JOIN station_names s1
		ON t.start_station_name_id = s1.id 
	JOIN station_names s2
		ON t.end_station_name_id = s2.id 
	JOIN member_types m
		ON t.member_type_id = m.id;