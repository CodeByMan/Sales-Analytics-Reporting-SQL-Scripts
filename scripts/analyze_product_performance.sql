USE DataWarehouseAnalytics;

WITH yearly_sales AS (
    SELECT p.product_key, p.product_name,
           YEAR(f.order_date) AS order_year,
           SUM(f.sales_amount) AS revenue
    FROM gold.fact_sales f
    JOIN gold.dim_products p ON p.product_key = f.product_key
    WHERE f.order_date IS NOT NULL
    GROUP BY p.product_key, p.product_name, YEAR(f.order_date)
),
comparison AS (
    SELECT product_key, product_name, order_year, revenue,
           AVG(CAST(revenue AS DECIMAL(18, 2))) OVER (
               PARTITION BY product_key
           ) AS average_yearly_revenue,
           LAG(revenue) OVER (
               PARTITION BY product_key ORDER BY order_year
           ) AS previous_year_revenue
    FROM yearly_sales
)
SELECT product_key, product_name, order_year, revenue,
       average_yearly_revenue, previous_year_revenue,
       revenue - previous_year_revenue AS change_from_previous_year,
       CASE
           WHEN previous_year_revenue IS NULL THEN 'First year'
           WHEN revenue > previous_year_revenue THEN 'Increase'
           WHEN revenue < previous_year_revenue THEN 'Decrease'
           ELSE 'No change'
       END AS yearly_change
FROM comparison
ORDER BY product_key, order_year;
