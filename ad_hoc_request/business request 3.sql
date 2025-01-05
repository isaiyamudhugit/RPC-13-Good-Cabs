-- Business Request 3: City Level Repeat Passenger Trip Frequency Report -- 
select 
    c.city_name as City,
    sum(case when rt.trip_count = '2-Trips' then rt.repeat_passenger_count else 0 end) as 2_Trips,
    sum(case when rt.trip_count = '3-Trips' then rt.repeat_passenger_count else 0 end) as 3_Trips,
    sum(case when rt.trip_count = '4-Trips' then rt.repeat_passenger_count else 0 end) as 4_Trips,
	sum(case when rt.trip_count = '5-Trips' then rt.repeat_passenger_count else 0 end) as 5_Trips,
    sum(case when rt.trip_count = '6-Trips' then rt.repeat_passenger_count else 0 end) as 6_Trips,
    sum(case when rt.trip_count = '7-Trips' then rt.repeat_passenger_count else 0 end) as 7_Trips,
    sum(case when rt.trip_count = '8-Trips' then rt.repeat_passenger_count else 0 end) as 8_Trips,
    sum(case when rt.trip_count = '9-Trips' then rt.repeat_passenger_count else 0 end) as 9_Trips,
    sum(case when rt.trip_count = '10-Trips' then rt.repeat_passenger_count else 0 end) as 10_Trips
from trips_db.dim_repeat_trip_distribution rt
join trips_db.dim_city c 
on c.city_id = rt.city_id
group by c.city_name, c.city_id
order by 10_Trips desc;
