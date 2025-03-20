--QUESTION ONE 
--What is the total number of units sold per product SKU?

SELECT 
	productid,SUM(sales.inventoryquantity) AS total_units_sold
FROM 
	sales
GROUP BY 
	productid
ORDER BY 
	total_units_sold;	


--Question 2
--Which product category had the highest sales volume last month?

SELECT 
	productcategory, SUM(inventoryquantity) AS sales_volume
FROM 
	sales
JOIN 
	product ON product.productid = sales.productid
WHERE 
	sales_year='2022' AND sales_month ='11'
GROUP BY 
	productcategory
ORDER BY 
	sales_volume DESC	
LIMIT 1;

--QUESTION 3
--How does the inflation rate correlate with sales volume for a specific month?

SELECT 
	s.sales_year,s.sales_month,
	ROUND(AVG(f.inflationrate),2) AS Avg_inflation_rate,
	SUM(s.inventoryquantity)AS sales_volume
FROM 
	sales s
JOIN 
	factors f ON s.salesdate=f.salesdate
GROUP BY 
	s.sales_month,s.sales_year
ORDER BY 
	Avg_inflation_rate DESC;

--Question 4
/*What is the correlation between the inflation rate and sales quantity for all products combined on a
monthly basis over the last year*/




SELECT
	s.sales_year,s.sales_month,
	ROUND(AVG(f.inflationrate),2) AS Avg_inflation_rate,
	SUM(s.inventoryquantity)AS Total_quantity
FROM 
	sales s
JOIN 
	factors f ON s.salesdate=f.salesdate
WHERE 
	s.salesdate >=(CURRENT_DATE-INTERVAL '1 year')
GROUP BY 
	s.sales_month,s.sales_year
ORDER BY  
	 s.sales_month,s.sales_year;


--Question 5
--Did promotions significantly impact the sales quantity of products?
SELECT
	p.productcategory,
	ROUND(AVG(s.inventoryquantity)) AS Avg_sales_without_promotions,
	p.promotions
FROM
	sales s
JOIN
	product p ON p.productid = s.productid
WHERE p.promotions ='NO'
GROUP BY
	p.productcategory, p.promotions

UNION ALL
	
SELECT
	p.productcategory,
	ROUND(AVG(s.inventoryquantity)) AS Avg_sales_with_promotions,
	p.promotions
FROM
	sales s
JOIN
	product p ON p.productid= s.productid     
WHERE p.promotions ='YES'
GROUP BY
	p.productcategory, p.promotions;


--Question 6
--What is the average sales quantity per product category?

SELECT
	p.productcategory,
	ROUND(AVG(s.inventoryquantity)) AS Avg_sales_quantity
FROM sales s
JOIN
	product p ON p.productid = s.productid
GROUP BY
	p.productcategory;


--Question 7
--How does the GDP affect the total sales volume?

SELECT 
	s.sales_year,
	ROUND(SUM(f.gdp))AS Total_gdp,
	SUM(s.inventoryquantity) AS Total_sales
FROM 
	sales s
JOIN 
	factors f ON f.salesdate = s.salesdate
	
GROUP BY
	s.sales_year
ORDER BY Total_sales

--question 8
--What are the top 10 best-selling product SKUs?

SELECT
	productid,
	SUM(inventoryquantity) AS Total_units_sold
FROM
	sales 
GROUP BY 
	productid
ORDER BY
	Total_units_sold DESC
LIMIT
	10;


--Question
--How do seasonal factors influence sales quantities for different product categories?

SELECT 
		p.productcategory,
		ROUND(AVG(f.seasonalfactor),4) AS Avg_seasonal_factor,
		SUM(s.inventoryquantity) AS Total_qty
FROM 
	sales s
JOIN
	product p ON p.productid = s.productid
JOIN
	factors f ON f.salesdate = s.salesdate
GROUP BY
	p.productcategory
ORDER BY 
	Avg_seasonal_factor;

	
--QUESTION 10
/*What is the average sales quantity per product category, and how many products are within each
category were part of a promotion?*/

SELECT 
	p.productcategory,
	ROUND(AVG(s.inventoryquantity)) AS Avg_sales_qty,
	COUNT(CASE WHEN p.promotions = 'YES' THEN 1 END) AS Promotion_Count
FROM
	sales s
JOIN 
	Product p ON s.productid = p.productid






SELECT
    p.productcategory,
    ROUND(AVG(s.inventoryquantity)) AS Avg_sales_quantity,
    COUNT(DISTINCT p.productcategory) AS products_in_promotion
FROM
    product p
JOIN sales s ON s.productid = p.productid
WHERE
    p.promotions IN ('YES', 'NO') 
GROUP BY
    p.productcategory
ORDER BY
    Avg_sales_quantity; 


SELECT p.productcategory,
       ROUND(AVG(s.inventoryquantity),2) AS avg_sales_quantity
FROM sales s
JOIN product p ON p.productid = s.productid 
WHERE
    p.promotions IN ('YES', 'NO') A 	
GROUP BY p.productcategory
ORDER BY avg_sales_quantity;


SELECT
	p.productcategory,
	ROUND(AVG(s.inventoryquantity)) AS AVG_sales_quantity,
COUNT(CASE WHEN p.promotions = 'YES' THEN 1 END) AS Promotion_count

FROM sales s

JOIN  product p ON p.productid = s.productid

GROUP BY 
	p.productcategory
ORDER BY AVG_sales_quantity;






SELECT
    p.productcategory,
    ROUND(AVG(s.inventoryquantity)) AS Avg_sales_without_promotions,
    p.promotions
FROM
    sales s
JOIN
    product p ON p.productid = s.productid
WHERE p.promotions ='NO'
GROUP BY
    p.productcategory, p.promotions

UNION ALL
    
SELECT
    p.productcategory,
    ROUND(AVG(s.inventoryquantity)) AS Avg_sales_with_promotions,
    p.promotions
FROM
    sales s
JOIN product p ON p.productid=s.productid 
WHERE p.promotions ='YES'
GROUP BY
    p.productcategory, p.promotions;