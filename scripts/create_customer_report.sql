USE DataWarehouseAnalytics;

EXEC(N'CREATE OR ALTER VIEW gold.report_customers AS
WITH customer_metrics AS (
    SELECT c.customer_key, c.customer_number,
           CONCAT(c.first_name, '' '', c.last_name) AS customer_name,
           c.birthdate,
           COUNT(DISTINCT f.order_number) AS total_orders,
           COUNT(DISTINCT f.product_key) AS total_products,
           SUM(f.sales_amount) AS total_sales,
           SUM(f.quantity) AS total_quantity,
           MIN(f.order_date) AS first_order_date,
           MAX(f.order_date) AS last_order_date
    FROM gold.dim_customers c
    JOIN gold.fact_sales f ON f.customer_key = c.customer_key
    WHERE f.order_date IS NOT NULL
    GROUP BY c.customer_key, c.customer_number,
             c.first_name, c.last_name, c.birthdate
),
customer_ages AS (
    SELECT *,
           DATEDIFF(YEAR, birthdate, GETDATE())
           - CASE WHEN DATEADD(YEAR, DATEDIFF(YEAR, birthdate, GETDATE()), birthdate)
                    > CAST(GETDATE() AS DATE) THEN 1 ELSE 0 END AS age
    FROM customer_metrics
)
SELECT customer_key, customer_number, customer_name, age,
       CASE
           WHEN age IS NULL THEN ''Unknown''
           WHEN age < 20 THEN ''Under 20''
           WHEN age < 30 THEN ''20-29''
           WHEN age < 40 THEN ''30-39''
           WHEN age < 50 THEN ''40-49''
           ELSE ''50 and above''
       END AS age_group,
       CASE
           WHEN DATEDIFF(MONTH, first_order_date, last_order_date) >= 12
                AND total_sales > 5000 THEN ''VIP''
           WHEN DATEDIFF(MONTH, first_order_date, last_order_date) >= 12
                THEN ''Regular''
           ELSE ''New''
       END AS customer_segment,
       last_order_date,
       DATEDIFF(MONTH, last_order_date, GETDATE()) AS recency_months,
       total_orders, total_products, total_sales, total_quantity,
       DATEDIFF(MONTH, first_order_date, last_order_date) AS lifespan_months,
       CAST(1.0 * total_sales / NULLIF(total_orders, 0) AS DECIMAL(18, 2))
           AS average_order_value,
       CAST(1.0 * total_sales /
            (DATEDIFF(MONTH, first_order_date, last_order_date) + 1)
            AS DECIMAL(18, 2)) AS average_monthly_spend
FROM customer_ages');
