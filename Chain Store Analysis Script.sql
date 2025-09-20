create database if not exists Sales_db;
use Sales_db;


-- converting dates to proper data type

-- transaction table

describe transactions;
select * from transactions;

update transactions
set date = str_to_date(date,"%Y-%m-%d");

alter table transactions
modify column Date date;

select year(date),count(*) from transactions
group by 1;

-- customers table
describe customers;
select * from customers;

update customers
set birthdate = str_to_date(birthdate,"%Y-%m-%d"),
joindate = str_to_date(joindate,"%Y-%m-%d");


alter table customers
modify column birthdate date;

alter table customers
modify column joindate date;

select birthdate, timestampdiff(year,birthdate,current_date()) as age
from customers;


-- questions

-- Show all customers who joined in 2024
select * from customers where year(joindate) in (select extract(year from joindate) from customers where year(joindate) = 2024) order by joindate;

-- Find the number of transactions each customer has made
select concat(c.firstname," ",c.lastname) as "Full Name",
count(t.transactionid) as "Total Transactions"
from transactions as t 
join customers as c
on t.customerid = c.customerid
group by 1
order by 2 desc;

-- List all products in the "Electronics" category

select ProductName 
from products
where category = "Electronics";

-- Find the total number of male and female customers

select
case
	when gender = "M" then "Male"
	when gender = "F" then "Female"
end as Gender,
count(*) as Count
from customers
group by 1;


-- Total Sales Revenue


select concat("$ ",format(sum(p.unitprice * t.quantity),2)) as "Total Revenue"
from transactions as t
join products as p
on t.productid = p.productid;


-- sales by category

select p.category,concat("$ ",format(sum(p.unitprice * t.quantity),2)) as "Revenue"
from transactions as t
join products as p
on t.productid = p.productid
group by p.category;

-- Top 5 Customers by Spend

select concat(c.firstname," ",c.lastname) as Customer_Name,
concat("$ ",format(sum(p.unitprice * t.quantity),2)) as "Total Spent"
from transactions as t
join products as p
on t.productid = p.productid
join customers as c
on t.customerid = c.customerid
group by Customer_Name
order by 2 desc
limit 5;


-- Monthly Sales Trend

select date_format(t.date, "%Y-%M") as "Month",
concat("$ ",format(sum(p.unitprice * t.quantity),2)) as "Sales"
from transactions as t
join products as p
on t.productid = p.productid
group by Month
order by Month;

-- Sales by Payment Method

select t.paymentmethod as "Payment Method",
concat("$ ",format(sum(p.unitprice * t.quantity),2)) as "Sales"
from transactions as t
join products as p
on t.productid = p.productid
group by 1;

-- Store-wise Performance

select s.Storename as "Store Name",
concat("$ ",format(sum(p.unitprice * t.quantity),2)) as "Sales"
from transactions as t
join products as p
on t.productid = p.productid
join stores as s
on t.storeid = s.storeid
group by 1
order by Sales desc;

-- Region-wise Performance

select s.region as "Region",
concat("$ ",format(sum(p.unitprice * t.quantity),2)) as "Sales"
from transactions as t
join products as p
on t.productid = p.productid
join stores as s
on t.storeid = s.storeid
group by Region 
order by Sales desc;

-- Customer Demographics: Avg Age of Customers Buying Each Category

select p.category as "Product",
avg(timestampdiff(Year,c.birthdate,current_date())) as "Average Age"
from transactions as t
join products as p
on t.productid = p.productid
join customers as c
on t.customerid = c.customerid
group by 1;

-- Find the top 3 best-selling products (by quantity)

select p.productname as Product,
sum(t.quantity) as "Total Quantity"
from transactions as t
join products as p
on t.productid = p.productid
group by 1
order by 2 desc
limit 3;

with cte as (
	select p.productname as Product,p.category,
	sum(t.quantity) as "total Quantity",
    row_number() over(partition by p.category order by sum(t.quantity)) as rnk
	from transactions as t
	join products as p
	on t.productid = p.productid
    group by 1,2
)
select * from cte
where rnk <= 3;

-- List all customers who have spent more than $10000 in total

select concat(c.firstname," ",c.lastname) as "Full Name",
concat("$ ",format(sum(p.unitprice * t.quantity),2)) as "Total Spent"
from customers as c
join transactions as t
on c.customerid = t.customerid
join products as p
on t.productid = p.productid
group by 1
having sum(p.unitprice * t.quantity - t.discount) > 100000;

-- Which city has the most customers?

select s.city as "City",
count(c.customerid) as "Total Customers"
from stores as s
join transactions as t
on s.storeid = t.storeid
join customers as c
on c.customerid = t.customerid
group by 1
order by 2 desc;

-- Find the average quantity purchased per transaction for each product.

select p.productname as "Product",
avg(t.quantity) as "Average Quantity Purchased"
from products as p 
join transactions as t 
on t.productid = p.productid 
group by 1;

-- Calculate the profit per product.
select * from transactions;
select * from products;
select * from customers;
select * from stores;

select ProductName,
concat("$ ",round(UnitPrice-costprice)) as Profit
from products;

-- Find the most popular payment method per region

with cte as(
	select s.region as Region,
	t.paymentmethod as PaymentMethod,
	count(*) as Count,
	row_number() over(partition by s.region order by count(*) desc) as rnk
	from transactions as t
	join stores as s
	on t.storeid = s.storeid
	group by 1,2
)
select * from cte
where rnk = 1;


-- Find customers who joined in the last 90 days and already made at least 1 purchase

select distinct concat(c.firstname," ",c.lastname) as CustomerName,
c.joindate as "Join Date",
count(transactionid) as "Total Transactions"
from customers as c
join transactions as t
on c.customerid = t.customerid
where c.joindate > current_date() - interval 90 day
group by 1,2;

-- Which customers haven’t made any transactions in the last 6 months?

select distinct concat(c.firstname," ",c.lastname) as CustomerName
from customers as c
left join transactions as t
on c.customerid = t.customerid
and t.date > current_date() - interval 6 month
where transactionid is null;


-- customer visits by city

select s.city as City,
count(c.customerid) as Customers
from stores as s
join transactions as t
on t.storeid = s.storeid
join customers as c
on c.customerid = t.customerid
group by 1
order by 2 desc;

-- sales growth % 

with cte as(
	select year(t.date) as Sales_Year,
    Month(t.date) as Sales_Month,
	sum(p.unitprice * t.quantity) as "Revenue"
	from products as p
	join transactions as t
	on t.productid = p.productid
	group by 1,2
),
cte2 as(
	select *,
	lag(Revenue,1) over(order by Sales_Year,Sales_Month ) as x
	from cte
)
select *,
       case when x is null or x = 0 then null
            else concat(format((Revenue - x) * 100.0 / x, 2), "%")
       end as growth_pct
from cte2;


-- year over year sales

with cte as (
	select year(t.date) as Sales_Year,
		Month(t.date) as Sales_Month,
		sum(p.unitprice * t.quantity) as Revenue
	from transactions as t
	join products as p
	on t.productid = p.productid
	group by 1,2
	order by 1,2
)
select *,
sum(revenue) over(partition by Sales_Year order by Sales_Month) as "Cumulative Revenue"
from cte;


