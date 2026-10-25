USE DataWarehouseAnalytics;

SELECT SUM(sales_amount) AS total_sales,
       SUM(quantity) AS total_quantity,
       AVG(CAST(price AS DECIMAL(12, 2))) AS average_price,
       COUNT(DISTINCT order_number) AS total_orders,
       COUNT(DISTINCT customer_key) AS buying_customers
FROM gold.fact_sales;

SELECT COUNT(*) AS total_products FROM gold.dim_products;
SELECT COUNT(*) AS total_customers FROM gold.dim_customers;
