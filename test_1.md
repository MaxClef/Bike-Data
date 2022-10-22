Bike Data
================
MaxClef

### How do annual members and casual riders use Cyclistic bikes differently?

Importing libraries

    ## Warning: package 'RPostgres' was built under R version 4.1.3

    ## Warning: package 'DBI' was built under R version 4.1.3

    ## Warning: package 'getPass' was built under R version 4.1.3

    ## Warning: package 'tidyverse' was built under R version 4.1.3

    ## Warning: package 'tibble' was built under R version 4.1.3

    ## Warning: package 'readr' was built under R version 4.1.2

    ## Warning: package 'purrr' was built under R version 4.1.3

    ## Warning: package 'dplyr' was built under R version 4.1.3

**Based on all the information found while working with the data in SQL,
I decided to import:**

-   data that includes only `classic_bike` and `electric_bike`

Connecting to the database/getting the data

``` r
con <- dbConnect(RPostgres::Postgres(),
                 dbname = 'divvy-tripdata', 
                 host = "localhost", 
                 port = 5432, 
                 user = "postgres",
                 password = getPass())
```

    ## Please enter password in TK window (Alt+Tab)

``` r
query = "
  SELECT 
    m.member_type,
    b.bike_type,
    s1.station_name AS start_station_name,
    s2.station_name AS end_station_name,
    t.duration_minutes,
    t.started_at AS started_time,
    t.ended_at AS ended_time,
    t.distance_meters,
    t.start_lat,
    t.start_lng,
    t.end_lat,
    t.end_lng
  FROM
    trip_data_past_year t
      JOIN member_types m
          ON t.member_type_id = m.id
      JOIN bikes b
          ON t.bike_type_id = b.id
      JOIN station_names s1
          ON t.start_station_name_id = s1.id
      JOIN station_names s2
          ON t.end_station_name_id = s2.id
  WHERE b.bike_type IN ('classic_bike', 'electric_bike');
"

data <- dbGetQuery(con, query)

dbDisconnect(con)
```

Checking the retrieved data

``` r
str(data)
```

    ## 'data.frame':    4179035 obs. of  12 variables:
    ##  $ member_type       : chr  "casual" "member" "member" "casual" ...
    ##  $ bike_type         : chr  "classic_bike" "electric_bike" "electric_bike" "classic_bike" ...
    ##  $ start_station_name: chr  "Shedd Aquarium" "Shedd Aquarium" "Avers Ave & Belmont Ave" "Adler Planetarium" ...
    ##  $ end_station_name  : chr  "Theater on the Lake" "Adler Planetarium" "Kenosha & Wellington" "Adler Planetarium" ...
    ##  $ duration_minutes  : num  136.3 26.88 5.12 84.88 4.75 ...
    ##  $ started_time      : POSIXct, format: "2022-07-23 08:20:17" "2021-11-02 12:49:35" ...
    ##  $ ended_time        : POSIXct, format: "2022-07-23 10:36:35" "2021-11-02 13:16:28" ...
    ##  $ distance_meters   : num  6698 688 1173 0 0 ...
    ##  $ start_lat         : num  41.9 41.9 41.9 41.9 41.7 ...
    ##  $ start_lng         : num  -87.6 -87.6 -87.7 -87.6 -87.6 ...
    ##  $ end_lat           : num  41.9 41.9 41.9 41.9 41.7 ...
    ##  $ end_lng           : num  -87.6 -87.6 -87.7 -87.6 -87.6 ...

Splitting columns `started_time` and `ended_time` into:

-   year - for year (e.g., 2022)

-   month - for month (e.g., August)

-   day - for day of the week (e.g., Monday)

-   start\_hour - for hour (e.g., 19)

-   start\_minute - for minutes (e.g., 02)

-   end\_hour - for hour (e.g., 19)

-   end\_minute - for minutes (e.g., 02)

``` r
data$year <- format(data$started_time, "%Y")

data$month <- format(data$started_time, "%B")

data$day <- format(data$started_time, "%A")
```

Converting `month` and `day` into factors (when plotting they will be
orgered correctlly)

``` r
data$month <- factor(data$month,
                     levels = c("October", "November", "December", "January", 
                                "February", "March", "April", "May", "June",
                                "July", "August", "September"))
data$day <- factor(data$day, 
                   levels = c("Monday", "Tuesday", "Wednesday", "Thursday",
                              "Friday", "Saturday", "Sunday"))
```

Checking mutated datarfame

``` r
str(data)
```

    ## 'data.frame':    4179035 obs. of  15 variables:
    ##  $ member_type       : chr  "casual" "member" "member" "casual" ...
    ##  $ bike_type         : chr  "classic_bike" "electric_bike" "electric_bike" "classic_bike" ...
    ##  $ start_station_name: chr  "Shedd Aquarium" "Shedd Aquarium" "Avers Ave & Belmont Ave" "Adler Planetarium" ...
    ##  $ end_station_name  : chr  "Theater on the Lake" "Adler Planetarium" "Kenosha & Wellington" "Adler Planetarium" ...
    ##  $ duration_minutes  : num  136.3 26.88 5.12 84.88 4.75 ...
    ##  $ started_time      : POSIXct, format: "2022-07-23 08:20:17" "2021-11-02 12:49:35" ...
    ##  $ ended_time        : POSIXct, format: "2022-07-23 10:36:35" "2021-11-02 13:16:28" ...
    ##  $ distance_meters   : num  6698 688 1173 0 0 ...
    ##  $ start_lat         : num  41.9 41.9 41.9 41.9 41.7 ...
    ##  $ start_lng         : num  -87.6 -87.6 -87.7 -87.6 -87.6 ...
    ##  $ end_lat           : num  41.9 41.9 41.9 41.9 41.7 ...
    ##  $ end_lng           : num  -87.6 -87.6 -87.7 -87.6 -87.6 ...
    ##  $ year              : chr  "2022" "2021" "2022" "2022" ...
    ##  $ month             : Factor w/ 12 levels "October","November",..: 10 2 8 8 12 10 10 9 10 7 ...
    ##  $ day               : Factor w/ 7 levels "Monday","Tuesday",..: 6 2 3 1 7 6 5 6 7 3 ...

Checking the number of missing values in each column

``` r
colSums(is.na(data))
```

    ##        member_type          bike_type start_station_name   end_station_name 
    ##                  0                  0                  0                  0 
    ##   duration_minutes       started_time         ended_time    distance_meters 
    ##                  0                  0                  0                  0 
    ##          start_lat          start_lng            end_lat            end_lng 
    ##                  0                  0                  0                  0 
    ##               year              month                day 
    ##                  0                  0                  0

No missing values are present

### Checking for Inconsitencies

Visualizing `duration_minuts`

``` r
ggplot(data) +
  geom_boxplot(aes(x = duration_minutes, fill = "#0c4c8a")) +
  labs( title = "Bike Usage Time", x = "Minutes") +
  theme( legend.position = "none")
```

![](test_1_files/figure-gfm/unnamed-chunk-8-1.png)<!-- -->

Percentiles

``` r
quantile(data$duration_minutes)
```

    ##      0%     25%     50%     75%    100% 
    ##    1.00    6.32   10.70   18.65 1499.90

Descriptive statistics for `duration_minuts`

``` r
psych::describe(data$duration_minutes)
```

    ##    vars       n  mean    sd median trimmed  mad min    max  range  skew
    ## X1    1 4179035 16.26 26.85   10.7   12.49 7.86   1 1499.9 1498.9 21.65
    ##    kurtosis   se
    ## X1   812.18 0.01

Looking at the maximum duration for 95% of the time

``` r
upper_bound <- quantile(data$duration_minutes, 0.95)
upper_bound
```

    ##   95% 
    ## 43.72

It’s clear that variable `duration_minutes` is right skewed based on the
mean (16.26) and trimmed mean (12.49)

I doubt there are people that use the bikes for up to 1000+ minutes (16+
hours)

Even if they do these are clear outliers, I mean the pricing is steep:

-   members :

    -   classic bikes ($119 per year):

        -   unlocking the bike - free
        -   usage - free 45 minutes at a time
        -   over 45 minutes is $0.16 per minute

    -   electric bikes ($119 per year)

        -unlocking the bike - free

        -   usage - $0.16 per minute
        -   parking has extra charges based on location

-   casual:

    -   classic bikes:

        -   unlocking the bike - $1
        -   usage - $0.16 per minute

    -   electric bikes

        -unlocking the bike - $1

        -   usage - $0.39 per minute
        -   parking has extra charges based on location

There is also a third category of users which are casual members that
get a `daily pass`. They have 3 hours of free rides for 24 hours for
classic bikes.

Sources [here](https://divvybikes.com/pricing) and
[here](https://divvybikes.com/pricing/ebikes)

The battery of an electric bike lasts maximum for 60 miles. If we assume
that the person rides one non-stop at a maximum speed of 3 hours, thay
have enough battery only for 3 hours.

Source
[here](https://ride.divvybikes.com/blog/new-divvy-ebike#:~:text=Longer%20rides%3A%20We've%20increased,operations%20trips%20to%20replace%20batteries.)

Based on all of the above I decided to remove all that have a duration
above 43.72 minutes. Meaning, removing 5% (208,951 values) from the
data.

``` r
clean_data <- data %>% filter(duration_minutes <= 43.72 )
```

Visualizing cleaned data

``` r
ggplot(clean_data) +
  geom_boxplot(aes(x = duration_minutes, fill = "#0c4c8a")) +
  labs( title = "Bike Usage Time", x = "Minutes",
        subtitle = "Cleaned Data") +
  theme( legend.position = "none")
```

![](test_1_files/figure-gfm/unnamed-chunk-13-1.png)<!-- -->

### 1. How do annual members and casual riders use Cyclistic bikes differently?

<span style="color:blue">**Difference in time usage by group**</span>

Visualizing duration by group and bike type

``` r
ggplot(clean_data, aes(x = member_type, y = duration_minutes, fill = member_type)) +
  stat_boxplot(geom = "errorbar", width = 0.25) +
  geom_boxplot() + 
  labs(title = "Bike Usage", subtitle = "Bike Type and User Type", caption = "Past 12 mth",
      x = "Type of User", y =  "Duration") + 
  theme(legend.position = "none") +
  facet_wrap(~bike_type)
```

![](test_1_files/figure-gfm/unnamed-chunk-14-1.png)<!-- -->

Mean for each group by usage of bike type

``` r
clean_data %>% group_by(member_type, bike_type) %>% summarise_at(vars(duration_minutes), 
                                                           list(mean = "mean"))
```

    ## # A tibble: 4 x 3
    ## # Groups:   member_type [2]
    ##   member_type bike_type      mean
    ##   <chr>       <chr>         <dbl>
    ## 1 casual      classic_bike   15.8
    ## 2 casual      electric_bike  13.7
    ## 3 member      classic_bike   12.1
    ## 4 member      electric_bike  10.6

Looks like on average casual users tend to use the bikes for a longer
period of time.

<span style="color:blue">**Bike usage by month for each group**</span>

Plot the difference in usage of bikes by month

``` r
ggplot(clean_data) +
  geom_bar(aes(x = month, fill = member_type, color = member_type), position = position_dodge(width=0.5)) +
  coord_flip() +
  labs(title = "Bikes Usage", subtitle = "Bike Type and User Type", caption = "Past 12 mth") +
  theme(axis.text.x = element_text(angle=25)) +
  scale_y_continuous(labels = function(x) format(x, scientific = FALSE)) +
  facet_wrap(~bike_type)
```

![](test_1_files/figure-gfm/unnamed-chunk-16-1.png)<!-- -->

Based on the plot above we see that the only time when the casual users
use the services more than the members is in the month of July for
electric bikes.Potentially because of summer tourists.

Another factor for bike usages could be the weather.

Casual users contingency table by month and type of bike

``` r
casual_users <- data %>% filter(member_type == "casual")
c_table <- prop.table(table(casual_users$bike_type, casual_users$month)) * 100
addmargins(round(c_table, 2))
```

    ##                
    ##                 October November December January February March April   May
    ##   classic_bike     6.57     1.98     1.23    0.43     0.50  2.20  2.95  7.78
    ##   electric_bike    3.81     1.91     1.28    0.30     0.36  1.47  2.02  4.22
    ##   Sum             10.38     3.89     2.51    0.73     0.86  3.67  4.97 12.00
    ##                
    ##                  June  July August September   Sum
    ##   classic_bike  10.48  9.61   7.94      6.51 58.18
    ##   electric_bike  5.68  7.70   7.12      5.94 41.81
    ##   Sum           16.16 17.31  15.06     12.45 99.99

casual users use classic bikes through out the year more often than
electric bikes:

-   58.18% using classical bikes usage
-   41.81% using electric bikes usage

Members contingency table by month and type of bike

``` r
casual_users <- data %>% filter(member_type == "member")
c_table <- prop.table(table(casual_users$bike_type, casual_users$month)) * 100
addmargins(round(c_table, 2))
```

    ##                
    ##                 October November December January February March April   May
    ##   classic_bike     7.92     4.60     3.04    1.80     1.92  3.73  4.49  7.44
    ##   electric_bike    2.93     2.39     1.90    0.74     0.86  1.87  2.30  3.13
    ##   Sum             10.85     6.99     4.94    2.54     2.78  5.60  6.79 10.57
    ##                
    ##                  June  July August September   Sum
    ##   classic_bike   8.89  8.16   8.11      7.55 67.65
    ##   electric_bike  3.40  4.21   4.42      4.18 32.33
    ##   Sum           12.29 12.37  12.53     11.73 99.98

Members are using classic bike though out the year more often than
electric once:

-   67.65% classic bikes usage
-   32.33% electric bikes usage

<span style="color:blue"> **Busiest days of each month**</span>

**Casual**

``` r
casual <- filter(data, member_type == "casual")
ct_casual <- as.data.frame(table(casual$day, casual$month))

ggplot(ct_casual, aes(x = Var1, y = Var2)) +
  geom_tile(aes(fill = Freq)) + 
  geom_text(aes(label = round(Freq, 4)), size = 2) +
  scale_fill_gradient(low = "white", high = "orange") +
  labs(title = "Usage by Month and Day for Casual Members", x = "Day", y =  "Month") +
  theme(text = element_text(size = 10))
```

![](test_1_files/figure-gfm/unnamed-chunk-19-1.png)<!-- --> Casual
members have a higher frequency of bike riding on the weekends

**Mabers**

``` r
member <- filter(data, member_type == "member")
ct_members <- as.data.frame(table(member$day, member$month))

ggplot(ct_members, aes(x = Var1, y = Var2)) +
  geom_tile(aes(fill = Freq)) + 
  geom_text(aes(label = round(Freq, 4)), size = 2) +
  scale_fill_gradient(low = "white", high = "orange") +
  labs(title = "Usage by Month and Day for Monthly Members", x = "Day", y =  "Month") +
  theme(text = element_text(size = 10))
```

![](test_1_files/figure-gfm/unnamed-chunk-20-1.png)<!-- --> Members seem
to be be biking more often on the week days.

<span style="color:blue"> **Top 10 popular starting points by
group**</span>

**Casual**

``` r
count(casual, start_station_name, sort = T)[1:10, ]
```

    ##                    start_station_name     n
    ## 1             Streeter Dr & Grand Ave 41757
    ## 2   DuSable Lake Shore Dr & Monroe St 22474
    ## 3               Michigan Ave & Oak St 18987
    ## 4  DuSable Lake Shore Dr & North Blvd 18629
    ## 5                     Millennium Park 18386
    ## 6                 Theater on the Lake 14519
    ## 7               Wells St & Concord Ln 14445
    ## 8                      Shedd Aquarium 14022
    ## 9             Clark St & Armitage Ave 11778
    ## 10                  Clark St & Elm St 11756

**Members**

``` r
count(member, start_station_name, sort = T)[1:10, ]
```

    ##              start_station_name     n
    ## 1      Kingsbury St & Kinzie St 24485
    ## 2             Clark St & Elm St 21364
    ## 3         Wells St & Concord Ln 20558
    ## 4  Clinton St & Washington Blvd 18595
    ## 5       Clinton St & Madison St 18438
    ## 6             Wells St & Elm St 18176
    ## 7      Loomis St & Lexington St 17284
    ## 8           Ellis Ave & 60th St 16909
    ## 9      University Ave & 57th St 16584
    ## 10        Dearborn St & Erie St 16465
