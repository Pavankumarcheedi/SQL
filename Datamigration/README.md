# 💇‍♂️ Hair Salon Data Migration Project

## 📌 Project Overview

This project involves migrating multiple CSV datasets related to a hair salon business from **Google Cloud Storage (GCS)** into a **SQL Server database** using a **Python-based automation script**. The datasets include client cancellations, future bookings, product listings, transaction records, and no-show reports.

---

## 🧰 Tools & Technologies Used

- **Google Cloud Storage (GCS)** – for hosting raw CSV files
- **SQL Server Express + SSMS** – for creating the target database and tables
- **Python (with pyodbc and pandas)** – for reading CSVs and inserting into SQL Server
- **ODBC Driver 17 for SQL Server** – for Python to connect to SQL Server

---

## 🪣 Step 1: Google Cloud Storage Setup

- A GCS bucket named `data_migration_pr1` was created.
- Cleaned CSV files were uploaded to this bucket. File names included:
  - `Client Cancellations0.csv`
  - `Future Bookings (All Clients)0.csv`
  - `No-Show Report0.csv`
  - `Product Listing (Retail)0.csv`
  - `Receipt Transactions0.csv`



## 🛠️ Step 2: SQL Server & SSMS Setup

- Installed **SQL Server Express** (local development database engine).
- Installed **SQL Server Management Studio (SSMS)** to manage databases visually.
- Created a new database: `HairSalonDB`.
- Manually created tables for each dataset (5 tables in total).
- Column names and types were set to accommodate the incoming CSV data.
- Used **Windows Authentication** (Trusted Connection) for easy local development.

- ## 🧰 What Is SSMS Used For?

**SQL Server Management Studio (SSMS)** is the official GUI tool provided by Microsoft to manage SQL Server databases, including SQL Server Express.

### 🔧 Key Uses of SSMS

| Feature               | What You Can Do                                                     |
|------------------------|---------------------------------------------------------------------|
| Run SQL Queries        | Create tables, insert data, run `SELECT`, `UPDATE`, `DELETE`, etc. |
| Create/Manage Databases| Easily add or manage databases like `HairSalonDB`                 |
| Visualize Tables       | Browse tables and view data in a spreadsheet-style format          |
| Debug Errors           | View detailed error messages and fix schema/data type issues       |
| Monitor Server         | Check server status, logs, sessions, and active connections        |

## 🗄️ Role of SQL Server Express in This Project

- **Local Database Engine**: Hosts the `HairSalonDB` where data is migrated.
- **Data Storage**: Stores structured salon data (client records, bookings, products, etc.).
- **Integration Target**: Python connects to it via `ODBC` for automated data migration.
- **Compatible with SSMS**: Managed easily using SQL Server Management Studio.

✅ It was essential for building, testing, and verifying the data pipeline from GCS to a relational database.


---

## 🔌 Step 3: Python Environment Setup

- Installed the following Python libraries:
  ```bash
  pip install pyodbc pandas

