--------------------------------------------------------------
---------------   Adding New Columns    ----------------------
--------------------------------------------------------------

/*
Things to do:

1. Create a new column `duration_minutes`: 
	* The length of the bike usage in minutes.
	* The data will be converted into a float format,
	  up to two decimal points.
2. Create a column `distance`:
		The distance traveled by the user
*/

--1. Create a new column `duration_minutes`
ALTER TABLE  trip_data_past_year 
	ADD COLUMN duration_minutes float; 


-- calculating duration and inserting it into the column
UPDATE trip_data_past_year 
SET duration_minutes = t.duration
FROM (
	SELECT 
		ride_id,
 		round(EXTRACT(epoch FROM ended_at - started_at) / 60, 2)  AS duration
	FROM trip_data_past_year) AS t
WHERE trip_data_past_year.ride_id = t.ride_id;


-- check
SELECT 
	started_at,
	ended_at,
	duration_minutes
FROM 
 trip_data_past_year
LIMIT 10; 

/*
2. Create a column `distance`:
		The distance traveled by the user

I will be using `earthdistance` module with cube calculations
to calculate the distance between the start and the end of the journey. 

It's not 100% persent accurate ("less than a full meter on a distance of 300 meters"), 
but enough for my analysis. 
I'm more concerned with measuring the speed and identifying if it's to high 
for it to be true, while looking for inconsistencies in the the data. 

Source: https://hashrocket.com/blog/posts/juxtaposing-earthdistance-and-postgis
*/

create extension if not exists cube;
create extension if not exists earthdistance;

-- creating column disctance_meters
ALTER TABLE trip_data_past_year 
	ADD COLUMN distance_meters float; 

-- calculating distance and inserting it into the column
UPDATE trip_data_past_year 
SET distance_meters = t.distance
FROM (
	SELECT 
		ride_id,
		earth_distance (
			ll_to_earth(start_lat, start_lng),
			ll_to_earth(end_lat, end_lng) 
		) AS distance
	FROM trip_data_past_year ) AS t
WHERE trip_data_past_year.ride_id = t.ride_id;