-------------------------------------------------------------
---------------   Cleaning the Data    ----------------------
-------------------------------------------------------------

/*
Things to check:

* Duration of the trip:
1. Rides are under 1 minute.
	"The data has been processed to remove trips that are taken by staff 
	as they service and inspect the system; and any trips that were below 60 
	seconds in length (potentially false starts or users trying 
	to re-dock a bike to ensure it was secure)"

	source: https://ride.divvybikes.com/system-data

2.	Where the station is the same and the duration of the trip 
	is shorter than 3 minutes. 
	
3. Cycling speed:
"No person shall operate a bicycle at a speed greater than is reasonable
and prudent under the conditions then existing."

	Source: https://www.chicagobikelawfirm.com/blog/chicagos-bike-laws-all-in-one-place/

 	Where the speed exceeds 20 miles per hour (I think 20 miles per hour
	would be a maxium top speed for any cyclist in a city) 
*/


-------------------------------------------------------------
---------------   1. Rides under 1 minute    ----------------
-------------------------------------------------------------

-- checking how many rides are under 1 minute 
SELECT 
	count(duration_minutes)
FROM 
	trip_data_past_year 
WHERE duration_minutes < 1;
-- Result: there are 115,280 instances 

-- removing them 
DELETE FROM trip_data_past_year 
WHERE duration_minutes < 1;


----------------------------------------------------------------
-- Same start and end stations with duration under 3 minutes ---
----------------------------------------------------------------

-- checking how many instances meet the criteria
SELECT 
	count(*) 
FROM 
	trip_data_past_year t
	JOIN station_names s1
		ON t.start_station_name_id = s1.id 
	JOIN station_names s2
		ON t.end_station_name_id = s2.id
WHERE duration_minutes < 3
AND s1.station_name = s2.station_name;
-- Result: there are 34,062 instances

-- removing them
DELETE FROM trip_data_past_year 
WHERE trip_data_past_year.ride_id IN (
	SELECT 
		t.ride_id 
	FROM 
		trip_data_past_year t
		JOIN station_names s1
			ON t.start_station_name_id = s1.id 
		JOIN station_names s2
			ON t.end_station_name_id = s2.id
	WHERE duration_minutes < 3
	AND s1.station_name = s2.station_name 
)
RETURNING *;


-------------------------------------------------------------
------  Where Speed Exceeds 20 miles per Hour  --------------
-------------------------------------------------------------

-- checking how many instances meet the criteria
SELECT 
	count(*)
FROM 
	trip_data_past_year 
WHERE (distance_meters * 0.000621371) / duration_minutes * 60 > 20;
-- Result: 3,934 instances

-- removing them
DELETE FROM trip_data_past_year 
WHERE trip_data_past_year.ride_id IN (
	SELECT 
		ride_id 
	FROM 
		trip_data_past_year 
	WHERE (distance_meters * 0.000621371) / duration_minutes * 60 > 20
);
