USE DataWarehouseAnalytics;

SELECT YEAR(order_date) AS order_year,
       MONTH(order_date) AS order_month,
       SUM(sales_amount) AS revenue,
       COUNT(DISTINCT customer_key) AS customers,
       SUM(quantity) AS units
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY order_year, order_month;

SELECT DATETRUNC(MONTH, order_date) AS month_start,
       SUM(sales_amount) AS revenue
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(MONTH, order_date)
ORDER BY month_start;
