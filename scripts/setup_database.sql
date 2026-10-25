USE master;

IF DB_ID(N'DataWarehouseAnalytics') IS NULL
    EXEC(N'CREATE DATABASE DataWarehouseAnalytics');

USE DataWarehouseAnalytics;

IF SCHEMA_ID(N'gold') IS NULL
    EXEC(N'CREATE SCHEMA gold');

IF OBJECT_ID(N'gold.dim_customers', N'U') IS NULL
BEGIN
    CREATE TABLE gold.dim_customers (
        customer_key INT NOT NULL PRIMARY KEY,
        customer_id INT NULL,
        customer_number NVARCHAR(50) NULL,
        first_name NVARCHAR(50) NULL,
        last_name NVARCHAR(50) NULL,
        country NVARCHAR(50) NULL,
        marital_status NVARCHAR(50) NULL,
        gender NVARCHAR(50) NULL,
        birthdate DATE NULL,
        create_date DATE NULL
    );
END;

IF OBJECT_ID(N'gold.dim_products', N'U') IS NULL
BEGIN
    CREATE TABLE gold.dim_products (
        product_key INT NOT NULL PRIMARY KEY,
        product_id INT NULL,
        product_number NVARCHAR(50) NULL,
        product_name NVARCHAR(50) NULL,
        category_id NVARCHAR(50) NULL,
        category NVARCHAR(50) NULL,
        subcategory NVARCHAR(50) NULL,
        maintenance NVARCHAR(50) NULL,
        cost INT NULL,
        product_line NVARCHAR(50) NULL,
        start_date DATE NULL
    );
END;

IF OBJECT_ID(N'gold.fact_sales', N'U') IS NULL
BEGIN
    CREATE TABLE gold.fact_sales (
        order_number NVARCHAR(50) NOT NULL,
        product_key INT NOT NULL,
        customer_key INT NOT NULL,
        order_date DATE NULL,
        shipping_date DATE NULL,
        due_date DATE NULL,
        sales_amount INT NULL,
        quantity TINYINT NULL,
        price INT NULL,
        PRIMARY KEY (order_number, product_key, customer_key),
        FOREIGN KEY (product_key) REFERENCES gold.dim_products(product_key),
        FOREIGN KEY (customer_key) REFERENCES gold.dim_customers(customer_key)
    );
END;
