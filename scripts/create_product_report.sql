USE DataWarehouseAnalytics;

EXEC(N'CREATE OR ALTER VIEW gold.report_products AS
WITH product_metrics AS (
    SELECT p.product_key, p.product_name, p.category, p.subcategory, p.cost,
           COUNT(DISTINCT f.order_number) AS total_orders,
           COUNT(DISTINCT f.customer_key) AS total_customers,
           SUM(f.sales_amount) AS total_sales,
           SUM(f.quantity) AS total_quantity,
           MIN(f.order_date) AS first_sale_date,
           MAX(f.order_date) AS last_sale_date
    FROM gold.dim_products p
    JOIN gold.fact_sales f ON f.product_key = p.product_key
    WHERE f.order_date IS NOT NULL
    GROUP BY p.product_key, p.product_name, p.category, p.subcategory, p.cost
)
SELECT product_key, product_name, category, subcategory, cost, last_sale_date,
       DATEDIFF(MONTH, last_sale_date, GETDATE()) AS recency_in_months,
       CASE
           WHEN total_sales > 50000 THEN ''High-Performer''
           WHEN total_sales >= 10000 THEN ''Mid-Range''
           ELSE ''Low-Performer''
       END AS product_segment,
       DATEDIFF(MONTH, first_sale_date, last_sale_date) AS lifespan_months,
       total_orders, total_sales, total_quantity, total_customers,
       CAST(1.0 * total_sales / NULLIF(total_quantity, 0) AS DECIMAL(18, 2))
           AS avg_selling_price,
       CAST(1.0 * total_sales / NULLIF(total_orders, 0) AS DECIMAL(18, 2))
           AS avg_order_revenue,
       CAST(1.0 * total_sales /
            (DATEDIFF(MONTH, first_sale_date, last_sale_date) + 1)
            AS DECIMAL(18, 2)) AS avg_monthly_revenue
FROM product_metrics');
