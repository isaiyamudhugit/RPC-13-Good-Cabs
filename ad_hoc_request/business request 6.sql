-- Business Request 6: Repeat Passenger Rate Analysis -- 
with MonthlyRepeat as (
	select f.city_id, c.city_name as City, 
	monthname(f.month) as Month,
	sum(f.total_passengers) as TotalPassengers,
	sum(f.repeat_passengers) as RepeatPassengers,
	concat(round(sum(f.repeat_passengers) * 100.0 / sum(f.total_passengers), 2), '%') as MonthlyRepeatPassengerRate
	from trips_db.fact_passenger_summary f
	join trips_db.dim_city c
	on f.city_id = c.city_id
	group by f.city_id, f.month
), CityRepeat as (
	select f.city_id,
	sum(f.total_passengers) as TotalPassengersByCity,
	sum(f.repeat_passengers) as RepeatPassengersByCity,
	concat(round(sum(f.repeat_passengers) * 100.0 / sum(f.total_passengers), 2), '%') as CityRepeatPassengerRate
	from 
	trips_db.fact_passenger_summary f
	group by 
	f.city_id
)
select City,Month,TotalPassengers, RepeatPassengers,
MonthlyRepeatPassengerRate,CityRepeatPassengerRate
from MonthlyRepeat as m
join CityRepeat as c
on m.city_id = c.city_id
order by City,Month;