create database Zepto_MYSQL_Project;

create table Zepto(
Category varchar(100),
name varchar(50) not null,
mrp numeric(8,2),
discountpercent numeric(5,2),
available_quantity int,
discountsellingprice numeric(8,2),
weightingrm int,
outofstock boolean,
quantity int
);

-- data exploration
select count(*) from zepto;

-- sample data
select * from zepto
limit 10;

-- null values
select * from zepto
where 
name is null
or mrp is null
or discountpercent is null
or availablequantity is null
or discountedsellingprice is null
or weightingms is null
or outofstock is null
or quantity is null;

-- different product categories
select distinct category
from zepto
order by category;

-- number of products in stock vs out of stock
select outofstock,count(*)
from zepto
group by outofstock;

-- product names present multiple times
select name,count(*) as "no of products"
from zepto
group by name
having count(*)>1
order by count(*) desc;

-- data cleaning

-- products with rpice = 0
select * 
from zepto
where mrp=0 or discountedsellingprice=0;

delete from zepto 
where mrp=0;

-- convert paise to rupees
update zepto
set mrp=mrp/100, 
discountedsellingprice= discountedsellingprice/100;

-- data analysis

-- Q1. Find the top 10 best-value products based on the discount percentage.
select distinct name,discountpercent
from zepto
order by discountpercent desc
limit 10;

-- Q2.What are the Products with High MRP but Out of Stock
select distinct name,mrp
from zepto
where outofstock=0 
order by mrp desc;

-- Q3.Calculate Estimated Revenue for each category
select category,sum(discountedsellingprice*availablequantity) as total_revenue
from zepto
group by category
order by total_revenue;

-- Q4. Find all products where MRP is greater than ₹500 and discount is less than 10%.
select DISTINCT name, mrp, discountPercent
from zepto
where mrp > 500 and discountpercent < 10
order by mrp desc, discountpercent desc;

-- Q5. Identify the top 5 categories offering the highest average discount percentage.
select category ,avg(discountpercent) as avg_discount
from zepto
group by category
order by avg_discount desc
limit 5;

-- Q6. Find the price per gram for products above 100g and sort by best value.
select name,weightInGms,discountedSellingPrice,(discountedSellingPrice/weightInGms) as price_per_grm
from zepto
where weightInGms>100
order by price_per_grm;

-- Q7.Group the products into categories like Low, Medium, Bulk.
select category,
case
when weightingms < 1000 then  "low"
when weightingms < 3000  then "medium"
else
"bulk"
end as category_weight
from zepto;

-- Q8.What is the Total Inventory Weight Per Category 
select category,SUM(weightInGms * availableQuantity) as total_weight
from zepto
group by category 
order by total_weight;