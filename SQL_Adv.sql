drop table if exists sales.dense_rank_demo;
CREATE TABLE sales.dense_rank_demo (
	v VARCHAR(10)
);
	
INSERT INTO sales.dense_rank_demo(v)
VALUES('A'),('B'),('B'),('C'),('C'),('D'),('E');
	

select * from sales.dense_rank_demo;



SELECT
	v,
	DENSE_RANK() OVER (
		ORDER BY v
	) my_dense_rank,
	RANK() OVER (
		ORDER BY v 
	) my_rank,
	percent_RANK() OVER (
		ORDER BY v
	) my_rank,
	row_number() over (order by v) as row_num
FROM
	sales.dense_rank_demo;

with cte as (
SELECT
	productid,
	name,
	listprice,
	DENSE_RANK () OVER ( 
		ORDER BY listprice DESC
	) price_rank 
FROM
	production.product)
select * from cte where price_rank <6	;

select * from production.product;

SELECT
	productid,
	name,
	SafetyStockLevel,
	listprice,
	RANK () OVER ( 
		PARTITION BY SafetyStockLevel
		ORDER BY listprice DESC
	) price_rank 
FROM
	production.product;

select * from Sales.salesorderheader ;

with cte as (
Select S.CustomerID,S.OrderDate as 'Last_Order',
S.SubTotal,
lag(s.OrderDate) over(partition by S.customerID order by S.orderdate)as 'Previous_Order'
from Sales.salesorderheader S
)
select *,datediff(day,Previous_Order,Last_Order) as days_diff from cte where Previous_Order is not null;

