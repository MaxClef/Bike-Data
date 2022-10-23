# Bike-Data

Data source: https://divvy-tripdata.s3.amazonaws.com/index.html

The data belongs to divvy bike-sharing company for the location in Chicago: https://divvybikes.com/

## Case study 
### How do annual members and casual riders use bikes differently?
  
#### Variables included in the data:
   * ride_id - unique identification number for each ride
   * rideable_type - type of bike (clessic or electric)
   * started_at - starting time of the ride
   * ened_at - finishing time of the ride
   * starte_station_name - starting station name
   * start_station_id - starting station id
   * end_station_name - ending station name
   * end_station_id - ending station id
   * start_lat - starting latitude
   * start_lng - starting longitude
   * end_lat - ending latitude
   * end_lng - ending longitude
   * member_casual - type of mamber using the bike (member, casual)
   
   
#### Files:
  * SQL - https://github.com/MaxClef/Bike-Data/tree/main/SQL
    * Importing and Merging Tables 
    * Normalizing the Data - creating columns and tables with foreign and primary keys
    * Cleaning - removing potential error
    * Duration and Distance Calculation - calculating time of useage and distance based on the geolocation
  * R - https://maxclef.github.io/Bike-Data-with-R-and-SQL/
    * Data Analysis
  * Tableua:
    * Starting stations by popularity - https://public.tableau.com/app/profile/maxim.clefos/viz/DIVVY-StartingStationbyPopularity/StartingstationsbyPopularity?publish=yes
    * Ending stations by popularity - https://public.tableau.com/app/profile/maxim.clefos/viz/DIVVY-EndingStationbyPopularity/DestinationsbyPopularity?publish=yes
   
   
 #### Learning outcome:
 * SQL:
    * inporting/creating/deleting/ tables
    * normalizing the data in a database
    * making calculations on rows
    * using JOIN/filtering data
  * R:
    * connecting to database
    * mutating data frame
    * plotting
    * using pipe operators
    * creating contingency table
    * discriptive statistics
  * Tableau:
    * creating location maps
  * GitHub Desktop
    * puching files
    * uploading R Markdown files to github repository
