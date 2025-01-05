-- Business Request 5: Identity month with higest revenue of each city -- 

with MonthlyRevenue as
( 
select 
distinct(city_name) as City,
monthname(t.date) as R_Month,
sum(t.fare_amount) as Revenue
from trips_db.fact_trips t
join trips_db.dim_city c
on t.city_id = c.city_id
GROUP BY c.city_name, MONTHNAME(t.date), MONTH(t.date), YEAR(t.date)
),
revenue_rank as
(
select 
City,R_Month,Revenue,
rank() over(partition by City order by Revenue desc) as Revenue_Rnk,
round(sum(Revenue) over(partition by City)) as TotCityRevenue
from MonthlyRevenue
)
select City,R_Month,Revenue ,
concat(round((Revenue / TotCityRevenue) * 100, 2), '%') as percentage_contribution
from revenue_rank where revenue_rnk = 1;
