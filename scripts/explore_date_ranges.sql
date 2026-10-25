USE DataWarehouseAnalytics;

SELECT MIN(order_date) AS first_order_date,
       MAX(order_date) AS last_order_date,
       DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS months_between
FROM gold.fact_sales;

SELECT MIN(birthdate) AS oldest_birthdate,
       MAX(birthdate) AS youngest_birthdate
FROM gold.dim_customers;
