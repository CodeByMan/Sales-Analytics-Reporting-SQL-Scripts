USE DataWarehouseAnalytics;

WITH category_sales AS (
    SELECT p.category, SUM(f.sales_amount) AS revenue
    FROM gold.fact_sales f
    JOIN gold.dim_products p ON p.product_key = f.product_key
    GROUP BY p.category
)
SELECT category, revenue,
       SUM(revenue) OVER () AS overall_revenue,
       CAST(100.0 * revenue / NULLIF(SUM(revenue) OVER (), 0) AS DECIMAL(6, 2))
           AS percent_of_total
FROM category_sales
ORDER BY revenue DESC;
