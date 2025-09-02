--show all records
select * from store;

--1.Show all orders with sales > 500
select * from store where SALES >500;

--2.List distinct product categories.
select distinct CATEGORY from store;

--3.Find total sales and profit for each region.
select COUNTRY_REGION,sum(SALES),sum(PROFIT)from store group by COUNTRY_REGION;

--4.Count how many unique customers are in the dataset
select count(distinct CUSTOMER_ID)as Unique_customers from store;

--5.Find top 10 highest sales transactions
select * from (select SALES from store order by SALES DESC)where rownum <=10;

--6.Find average discount given per category.
select CATEGORY,avg(DISCOUNT) from store group by CATEGORY;   

--7.Get total sales per customer segment.
select SEGMENT,sum(SALES)from store group by SEGMENT;

--8.List top 5 most profitable customers.
select *from (select CUSTOMER_ID,CUSTOMER_NAME,SUM(PROFIT) AS Total_Profit
    from store
    group by Customer_ID,CUSTOMER_NAME
    order by Total_Profit DESC )
where rownum <= 5;

--9.Show monthly sales trend (year, month, total sales)
select to_char(ORDER_DATE,'YYYY')as year,to_char(ORDER_DATE,'MM')as month,sum(SALES)
from store group by to_char(ORDER_DATE,'YYYY'),to_char(ORDER_DATE,'MM')order by year,month;

--10.Find total quantity sold for each sub-category
select SUB_CATEGORY,sum(QUANTITY)as total_quantity from store group by SUB_CATEGORY order by total_quantity desc;

--11.Which  sub-category has the highest profit?
select SUB_CATEGORY,total_profit from(select SUB_CATEGORY,sum(PROFIT)as total_profit from store group by SUB_CATEGORY order by total_profit desc)where rownum=1;

--12.Find top 3 products by sales in each region
select REGION,PRODUCT_NAME,total_sales from(select REGION,PRODUCT_NAME,sum(SALES)as total_sales,
RANK()OVER (PARTITION by REGION order by sum(SALES) desc )as rank_product from store group by REGION,PRODUCT_NAME) where rank_product<=3;

--13.Which ship mode gives the highest average profit?
select SHIP_MODE,highest_profit from( select SHIP_MODE,avg(PROFIT)as highest_profit from store group by SHIP_MODE order by highest_profit desc) where rownum=1;

--14.Compare average sales of high-discount vs low-discount orders
select discount_level,avg(SALES)as avg_sales from
   ( select case  
         when DISCOUNT >=0.2 then 'high_discount'
         else 'low_discount'
         end as discount_level,
         SALES
from store)group by discount_level

--15.Rank customers by total profit using RANK()
select CUSTOMER_ID,CUSTOMER_NAME,sum(PROFIT)as total_profit,RANK() OVER(order by sum(PROFIT) DESC) as profit_rank
from store group by CUSTOMER_ID,CUSTOMER_NAME order by profit_rank;


