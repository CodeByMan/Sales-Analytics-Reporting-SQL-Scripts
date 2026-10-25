USE DataWarehouseAnalytics;

SET XACT_ABORT ON;
BEGIN TRANSACTION;

BULK INSERT gold.dim_customers
FROM 'C:\CHANGE_ME\gold.dim_customers.csv'
WITH (FORMAT = 'CSV', FIRSTROW = 2, FIELDQUOTE = '"', CODEPAGE = '65001');

BULK INSERT gold.dim_products
FROM 'C:\CHANGE_ME\gold.dim_products.csv'
WITH (FORMAT = 'CSV', FIRSTROW = 2, FIELDQUOTE = '"', CODEPAGE = '65001');

BULK INSERT gold.fact_sales
FROM 'C:\CHANGE_ME\gold.fact_sales.csv'
WITH (FORMAT = 'CSV', FIRSTROW = 2, FIELDQUOTE = '"', CODEPAGE = '65001');

COMMIT TRANSACTION;

SELECT COUNT(*) AS customers FROM gold.dim_customers;
SELECT COUNT(*) AS products FROM gold.dim_products;
SELECT COUNT(*) AS sales_rows FROM gold.fact_sales;
