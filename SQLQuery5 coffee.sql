select*
from dbo.coffee_shop_sales;

exec Sp_columns coffee_shop_sales;

select round(sum(unit_price*transaction_qty),2) as total_sales
from coffee_shop_sales;

select round(sum(unit_price*transaction_qty),2) as total_sales
from coffee_shop_sales
where month(transaction_date) = 3;

select round(sum(unit_price*transaction_qty),2) as total_sales
from coffee_shop_sales
where month(transaction_date) = 5;

select round(sum(unit_price*transaction_qty),2) as total_sales
from coffee_shop_sales
where month(transaction_date) between 3 and 5;


select count(distinct product_category) as type_of_category
from coffee_shop_sales;

select
	round(sum(unit_price*transaction_qty),2) as total_sales,
	sum(transaction_qty) as total_qty_sold,
	count(transaction_id) as total_orders
from coffee_shop_sales
where transaction_date = '2023-06-30';

select transaction_date, datepart(weekday,transaction_date) as day_of_week_number
from coffee_shop_sales;

select transaction_date, datename(weekday,transaction_date) as day_of_week_name
from coffee_shop_sales;

select transaction_date, datename(weekday,transaction_date) as day_of_week_name, datepart(weekday,transaction_date) as day_of_week_number
from coffee_shop_sales;


select 
	case when datepart(weekday,transaction_date) in (1,7) Then 'weekends'
	else 'weekdays'
	end as day_type,
	sum(unit_price*transaction_qty) as total_sales
from coffee_shop_sales
group by 
	case when datepart(weekday,transaction_date) in (1,7) Then 'weekends'
	else 'weekdays'
	end;

select 
	case when datepart(weekday,transaction_date) in (1,7) Then 'weekends'
	else 'weekdays'
	end as day_type,
	sum(unit_price*transaction_qty) as total_sales
from coffee_shop_sales
where datepart(weekday,transaction_date) = 7
group by 
	case when datepart(weekday,transaction_date) in (1,7) Then 'weekends'
	else 'weekdays'
	end;

select transaction_date, datepart(month,transaction_date) as month_num
from coffee_shop_sales;

select transaction_date, datepart(month,transaction_date) as month_num, datename(month, transaction_date) as month
from coffee_shop_sales;

select transaction_date, 
	datepart(month,transaction_date) as month_num, 
	datename(month, transaction_date) as month, 
	datename(year, transaction_date) as year
from coffee_shop_sales;


select 
	case when datepart(weekday,transaction_date) in (1,7) Then 'weekends'
	else 'weekdays'
	end as day_type,
	sum(unit_price*transaction_qty) as total_sales_of_May
from coffee_shop_sales
where datepart(month,transaction_date) = 5
group by 
	case when datepart(weekday,transaction_date) in (1,7) Then 'weekends'
	else 'weekdays'
	end;

select store_location, round(sum(unit_price*transaction_qty),2) as total_sales
from coffee_shop_sales
where datepart(month,transaction_date) = 5
group by store_location
order by round(sum(unit_price*transaction_qty),2) desc;

select round(avg(unit_price*transaction_qty),2) as avg_sales
from coffee_shop_sales;

select round(avg(unit_price*transaction_qty),2) as avg_sales
from coffee_shop_sales
where datepart(month, transaction_date) = 5;

select sum(unit_price*transaction_qty) as total_sales
	from coffee_shop_sales
	where datepart(month,transaction_date) = 5
	group by transaction_date;

select avg(total_sales) as avg_sales
from
	(
	select sum(unit_price*transaction_qty) as total_sales
	from coffee_shop_sales
	where datepart(month,transaction_date) = 5
	group by transaction_date
	) as internal_query
	;
 
 select
	datepart(weekday, transaction_date) as day_of_month,
	sum(unit_price*transaction_qty) as total_sales
from coffee_shop_sales
where datepart(month, transaction_date) = 5
group by datepart(weekday, transaction_date)
order by datepart(weekday, transaction_date);

select day_of_month,
case when total_sales > avg_sales then 'above average'
	when total_sales < avg_sales then 'below average'
	else 'average'
	end as sales_status,
	total_sales
from (
select
	datepart(weekday, transaction_date) as day_of_month,
	sum(unit_price*transaction_qty) as total_sales,
	avg(sum(unit_price*transaction_qty)) over () as avg_sales
from coffee_shop_sales
where datepart(month, transaction_date) = 5
group by datepart(weekday, transaction_date)
) as sales_data
order by day_of_month;

select product_category, sum(unit_price*transaction_qty) as total_sales
from coffee_shop_sales
group by product_category
order by sum(unit_price*transaction_qty) desc
;

select product_category, sum(unit_price*transaction_qty) as total_sales_May
from coffee_shop_sales
where datepart(month, transaction_date) = 5
group by product_category
order by sum(unit_price*transaction_qty) desc
;

select product_type, sum(unit_price*transaction_qty) as total_sales
from coffee_shop_sales
group by product_type
order by sum(unit_price*transaction_qty) desc
;

select product_type, sum(unit_price*transaction_qty) as total_sales_May
from coffee_shop_sales
where datepart(month, transaction_date) = 5
group by product_type
order by sum(unit_price*transaction_qty) desc
;

select top 10 product_type, sum(unit_price*transaction_qty) as total_sales_May
from coffee_shop_sales
where datepart(month, transaction_date) = 5 and product_category = 'coffee'
group by product_type
order by sum(unit_price*transaction_qty) desc
;

select 
    case 
        when datepart(weekday, transaction_date) = 2 then 'Monday'
        when datepart(weekday, transaction_date) = 3 then 'Tuesday'
        when datepart(weekday, transaction_date) = 4 then 'Wednesday'
        when datepart(weekday, transaction_date) = 5 then 'Thursday'
        when datepart(weekday, transaction_date) = 6 then 'Friday'
        when datepart(weekday, transaction_date) = 7 then 'Saturday'
        else 'Sunday'
    end as Day_of_Week,
    round(sum(unit_price * transaction_qty),0) as Total_Sales
from
    coffee_shop_sales
group by  
    case 
        when datepart(weekday, transaction_date) = 2 then 'Monday'
        when datepart(weekday, transaction_date) = 3 then 'Tuesday'
        when datepart(weekday, transaction_date) = 4 then 'Wednesday'
        when datepart(weekday, transaction_date) = 5 then 'Thursday'
        when datepart(weekday, transaction_date) = 6 then 'Friday'
        when datepart(weekday, transaction_date) = 7 then 'Saturday'
        else 'Sunday'
    end;


select 
    case 
        when datepart(weekday, transaction_date) = 2 then 'Monday'
        when datepart(weekday, transaction_date) = 3 then 'Tuesday'
        when datepart(weekday, transaction_date) = 4 then 'Wednesday'
        when datepart(weekday, transaction_date) = 5 then 'Thursday'
        when datepart(weekday, transaction_date) = 6 then 'Friday'
        when datepart(weekday, transaction_date) = 7 then 'Saturday'
        else 'Sunday'
    end as Day_of_Week_May,
    round(sum(unit_price * transaction_qty),0) as Total_Sales
from
    coffee_shop_sales
where 
    datepart(month, transaction_date) = 5 
group by  
    case 
        when datepart(weekday, transaction_date) = 2 then 'Monday'
        when datepart(weekday, transaction_date) = 3 then 'Tuesday'
        when datepart(weekday, transaction_date) = 4 then 'Wednesday'
        when datepart(weekday, transaction_date) = 5 then 'Thursday'
        when datepart(weekday, transaction_date) = 6 then 'Friday'
        when datepart(weekday, transaction_date) = 7 then 'Saturday'
        else 'Sunday'
    end;
