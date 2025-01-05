-- Busines Request 2 - Monthly City Level Trips Target Performance Report -- 
with ActualTrips as (
    select city_id, count(trip_id) as actual_trip_count, max(date) as trip_date,year(date) as trip_year, month(date) as trip_month
    from trips_db.fact_trips
    group by city_id, year(date), month(date)
), TargetTrips AS (
    select city_id, sum(total_target_trips) as target_trip_count, year(month) as target_year, month(month) AS target_month
    from targets_db.monthly_target_trips
    group by city_id, year(month), month(month)
)
select c.city_name as City, monthname(a.trip_date) as month, a.actual_trip_count as ActualTrips, 
t.target_trip_count as TargetTrips,
concat(round((a.actual_trip_count / t.target_trip_count) * 100, 2), '%') as performance_percentage,
concat(round(((a.actual_trip_count - t.target_trip_count) / t.target_trip_count) * 100, 2), '%') as performance_gap,
case
	when a.actual_trip_count > t.target_trip_count then 'Above Target'
    else 'Below Target'
end as performance_status
from ActualTrips as a
join TargetTrips as t
on a.city_id = t.city_id 
    and a.trip_year = t.target_year 
    and a.trip_month = t.target_month
join trips_db.dim_city as c
on a.city_id = c.city_id;