USE DataWarehouseAnalytics;

WITH product_segments AS (
    SELECT product_key,
           CASE
               WHEN cost < 100 THEN 'Under 100'
               WHEN cost < 500 THEN '100 to 499'
               WHEN cost < 1000 THEN '500 to 999'
               ELSE '1000 or more'
           END AS cost_range
    FROM gold.dim_products
    WHERE cost IS NOT NULL
)
SELECT cost_range, COUNT(*) AS products
FROM product_segments
GROUP BY cost_range
ORDER BY products DESC;

WITH customer_spending AS (
    SELECT customer_key,
           SUM(sales_amount) AS total_spending,
           DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS lifespan_months
    FROM gold.fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY customer_key
),
customer_segments AS (
    SELECT customer_key,
           CASE
               WHEN lifespan_months >= 12 AND total_spending > 5000 THEN 'VIP'
               WHEN lifespan_months >= 12 THEN 'Regular'
               ELSE 'New'
           END AS segment
    FROM customer_spending
)
SELECT segment, COUNT(*) AS customers
FROM customer_segments
GROUP BY segment
ORDER BY customers DESC;
