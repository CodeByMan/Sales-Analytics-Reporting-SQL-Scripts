USE DataWarehouseAnalytics;

WITH monthly_sales AS (
    SELECT DATEFROMPARTS(YEAR(order_date), MONTH(order_date), 1) AS month_start,
           SUM(sales_amount) AS revenue,
           AVG(CAST(price AS DECIMAL(12, 2))) AS average_price
    FROM gold.fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY YEAR(order_date), MONTH(order_date)
)
SELECT month_start, revenue,
       SUM(revenue) OVER (ORDER BY month_start ROWS UNBOUNDED PRECEDING) AS running_revenue,
       AVG(average_price) OVER (
           ORDER BY month_start ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
       ) AS three_month_average_price
FROM monthly_sales
ORDER BY month_start;
