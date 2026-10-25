<div align="center">

# 📊 Advanced SQL Analytics and Reporting

SQL Server sales analysis using customer, product, and order data.

![SQL Server](https://img.shields.io/badge/Database-SQL%20Server-CC2927?style=for-the-badge&logo=microsoftsqlserver&logoColor=white)
![T-SQL](https://img.shields.io/badge/Language-T--SQL-0078D4?style=for-the-badge)
![Data](https://img.shields.io/badge/Datasets-17%20CSVs-16a34a?style=for-the-badge)

<p><b>Sales reporting · Customer analysis · Product rankings · SQL views</b></p>

</div>

---

## 📌 Project Overview

This project explores sales, customer, and product data with SQL Server. The scripts answer questions about revenue, orders, rankings, trends, customer segments, and category share. Two views summarize customer and product performance.

The supplied gold CSVs contain 18,484 customers, 295 products, and 60,398 sales rows. Their order dates range from 2010-12-29 to 2014-01-28. These counts and key relationships were checked in the CSV files. A SQL Server import and query run have not been verified.

## 🎯 Objectives

- Create a small relational model with customer, product, and sales tables.
- Load the supplied gold CSVs into SQL Server.
- Explore dimensions, measures, dates, and sales by category and country.
- Analyze rankings, monthly trends, running totals, yearly comparisons, and segments.
- Create customer and product reporting views.

## ✨ Main Features

- Primary keys on customers and products; a composite key and foreign keys on sales.
- Joins, aggregates, `CASE`, CTEs, and two reporting views.
- `RANK`, `LAG`, running totals, and moving averages in the relevant analytical scripts.
- Transactional bulk load for the three gold CSVs.
- Each script runs without a `GO` batch separator.

## 📊 Dataset Scope

| File group | Files | Use in this project |
| --- | ---: | --- |
| Bronze CSVs | 6 | Retained source data |
| Silver CSVs | 6 | Retained cleaned data |
| Gold table CSVs | 3 | Loaded by `load_gold_data.sql` |
| Gold report CSVs | 2 | Retained exports for reference |

The archive contains no supplied transformation scripts that rebuild silver and gold tables from bronze data. The report CSVs are not loaded into SQL Server; the reporting views compute their own results from the gold tables.

## 📁 Project Structure

```text
Advanced-SQL-Analytics-and-Reporting/
├── scripts/             # Setup, load, analysis, and report views
├── datasets/
│   ├── csv-files/       # 17 supplied CSV files
│   └── DataAnalytics.bak
├── README.md
├── LICENSE
└── .gitignore
```

## 🧭 SQL Script Guide

Run the setup and load scripts first. The analytical scripts are independent and can then be run in any order.

| Script | Purpose |
| --- | --- |
| `setup_database.sql` | Create the database, gold schema, three tables, and keys |
| `load_gold_data.sql` | Import the three gold table CSVs |
| `explore_database.sql` | List gold tables and customer columns |
| `explore_dimensions.sql` | Inspect countries and products |
| `explore_date_ranges.sql` | Check order and customer date ranges |
| `explore_measures.sql` | Calculate sales, quantity, orders, products, and customers |
| `analyze_magnitude.sql` | Group customers and sales by dimensions |
| `rank_products_and_customers.sql` | Find top and bottom performers and calculate ranks |
| `analyze_sales_trends.sql` | Summarize sales by month and year |
| `analyze_running_totals.sql` | Calculate a running total and moving average |
| `analyze_product_performance.sql` | Compare annual product sales using `LAG` |
| `segment_products_and_customers.sql` | Group products and customers into segments |
| `analyze_category_share.sql` | Calculate each category's percentage of sales |
| `create_customer_report.sql` | Create `gold.report_customers` |
| `create_product_report.sql` | Create `gold.report_products` |

## 🧰 Technology Stack

| Technology | Purpose |
| --- | --- |
| SQL Server 2022 / T-SQL | Database, `DATETRUNC`, queries, and views |
| CSV | Supplied source, prepared, and report datasets |
| SQL Server Management Studio | Suggested environment for manual execution |

## ⚙️ Run the Project

1. Run `scripts/setup_database.sql` on a SQL Server instance where you have permission to create a database. The script creates missing objects; it does not migrate existing tables.
2. Edit the three `C:\CHANGE_ME\` paths in `scripts/load_gold_data.sql` to full paths readable by the SQL Server service. Run it against empty gold tables. It does not update already loaded rows.
3. Check the returned row counts against the three gold CSV counts shown above.
4. Run the analytical scripts from `scripts/` as needed.
5. Run `scripts/create_customer_report.sql` and `scripts/create_product_report.sql`, then inspect `gold.report_customers` and `gold.report_products`.

`CREATE OR ALTER VIEW` runs inside `EXEC` so its definition is a separate SQL Server batch without `GO`. The bulk load uses `XACT_ABORT ON` and a transaction. Manual execution and output checks are still required.

## 🔎 Validation and Limitations

- A static CSV check found no duplicate customer or product keys, duplicate sales composite keys, or missing sales references to those dimensions.
- The supplied `datasets/DataAnalytics.bak` is one byte and is **not a usable SQL Server backup**. Create a new backup from a successfully loaded database if needed.
- No execution plans, runtime measurements, SQL Server test results, roles, permissions, or complete bronze-to-gold pipeline are supplied.
- The reporting views use the current SQL Server date for age and recency, so those values will change over time.

## 🧑‍💻 Developer and Attribution

**Muhammad Ali Nawaz**  
SQL Developer / Database Developer

This developer attribution is supplied by the person requesting these edits. The original uploaded README and `LICENSE` credit Sakshi Ingale. The claim that this was a temporary name cannot be verified from the supplied files, so the original copyright notice remains in `LICENSE` until provenance is established.

## 📄 License

See [LICENSE](LICENSE) for the existing MIT notice.
