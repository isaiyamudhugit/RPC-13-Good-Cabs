-- Business Problem 4:  Identify cities with highest and lowest Total New Passengers  -- 
with ranked_cities as (
	select c.city_name as City,
    sum(ps.new_passengers) as Total_New_Passenger,
    rank() over(order by sum(ps.new_passengers) desc) as rnk_desc,
    rank() over(order by sum(ps.new_passengers)) as rnk_asc
    from trips_db.fact_passenger_summary ps
    join trips_db.dim_city c
    on ps.city_id = c.city_id
    group by c.city_name
    order by Total_New_Passenger desc
)
select 
City, Total_New_Passenger,
case 
	when rnk_desc<=3 then 'Top 3'
    when rnk_asc<=3 then 'Bottom 3'
    else null
end as City_Category
from  ranked_cities
where rnk_desc <= 3 OR rnk_asc <= 3
order by Total_New_Passenger desc;
