USE DataWarehouseAnalytics;

SELECT TOP (5) p.product_key, p.product_name,
       SUM(f.sales_amount) AS revenue
FROM gold.fact_sales f
JOIN gold.dim_products p ON p.product_key = f.product_key
GROUP BY p.product_key, p.product_name
ORDER BY revenue DESC, p.product_key;

SELECT TOP (5) p.product_key, p.product_name,
       SUM(f.sales_amount) AS revenue
FROM gold.fact_sales f
JOIN gold.dim_products p ON p.product_key = f.product_key
GROUP BY p.product_key, p.product_name
ORDER BY revenue, p.product_key;

WITH product_sales AS (
    SELECT p.product_key, p.product_name,
           SUM(f.sales_amount) AS revenue
    FROM gold.fact_sales f
    JOIN gold.dim_products p ON p.product_key = f.product_key
    GROUP BY p.product_key, p.product_name
),
ranked_products AS (
    SELECT product_key, product_name, revenue,
           RANK() OVER (ORDER BY revenue DESC) AS sales_rank
    FROM product_sales
)
SELECT product_key, product_name, revenue, sales_rank
FROM ranked_products
WHERE sales_rank <= 5
ORDER BY sales_rank, product_key;

SELECT TOP (10) c.customer_key, c.first_name, c.last_name,
       SUM(f.sales_amount) AS revenue
FROM gold.fact_sales f
JOIN gold.dim_customers c ON c.customer_key = f.customer_key
GROUP BY c.customer_key, c.first_name, c.last_name
ORDER BY revenue DESC, c.customer_key;

SELECT TOP (3) c.customer_key, c.first_name, c.last_name,
       COUNT(DISTINCT f.order_number) AS orders
FROM gold.fact_sales f
JOIN gold.dim_customers c ON c.customer_key = f.customer_key
GROUP BY c.customer_key, c.first_name, c.last_name
ORDER BY orders, c.customer_key;
