-- Business Request 1: City Level Fare and Trip Summary Report -- 
select 
    c.city_name as City_Name, 
    count(t.trip_id) as Total_Trips, 
    round(avg(t.fare_amount / nullif(t.distance_travelled_km, 0)),2) as Avg_Fare_Per_KM, 
    round(sum(t.fare_amount) / count(t.trip_id), 2) as Avg_Fare_Per_Trip,
    concat(round((count(t.trip_id) * 100.0 / sum(count(t.trip_id)) over()), 2),'%') as Contribution_To_Total_Trips
from trips_db.fact_trips as t
join trips_db.dim_city as c
on t.city_id = c.city_id
group by c.city_name, t.city_id
order by Total_Trips desc;