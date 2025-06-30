<h1 align = center >Sales Performance Dashboard Project</h1>

<h2>Project Overview</h2>

This project focuses on analyzing sales performance data from a Superstore dataset to derive actionable business insights. 
The dataset, stored in a MySQL database, was cleaned, processed, and analyzed using SQL for data preparation and Pandas for data export. 
A comprehensive dashboard was built using Power BI to visualize key performance metrics, enabling stakeholders to make data-driven decisions.

The primary goal was to create an interactive dashboard that highlights sales, profit, and quantity metrics across various dimensions such as regions, categories, segments, and cities. 
The project demonstrates proficiency in SQL for data manipulation, Python (Pandas) for data export, and Power BI for data visualization.


<h4>Objectives</h4>

•	Data Cleaning: Ensure high-quality data by handling duplicates, null values, and negative profit entries.
•	Exploratory Data Analysis (EDA): Perform SQL-based analysis to uncover trends and patterns in sales, profit, and quantity metrics.
•	Data Export: Export cleaned data from MySQL to a CSV file using Python (Pandas) for further analysis.
•	Dashboard Creation: Build an interactive Power BI dashboard to visualize key metrics for stakeholders.
•	Actionable Insights: Provide insights to optimize sales strategies, identify high-performing regions and categories, and flag loss-making transactions.


<h4>Dataset</h4>

The dataset, SampleSuperstore.csv, contains 9,994 rows (reduced to 9,976 after cleaning) and 13 columns:
•	Ship Mode: Shipping method (e.g., Second Class, Standard Class)
•	Segment: Customer segment (e.g., Consumer, Corporate, Home Office)
•	Country: Country of transaction (United States)
•	City: City of transaction
•	State: State of transaction
•	Postal Code: Postal code of transaction
•	Region: Region (e.g., West, East, Central, South)
•	Category: Product category (e.g., Furniture, Office Supplies, Technology)
•	Sub_Category: Product sub-category (e.g., Chairs, Tables, Phones)
•	Sales: Sales amount (USD)
•	Quantity: Number of items sold
•	Discount: Discount applied
•	Profit: Profit amount (USD)
Methodology
1. Database Setup
•	Created a MySQL database (superstore_project) and a table (sales_performance_dashboard) to store the dataset.
•	Enabled MySQL's LOCAL INFILE feature to load data from the CSV file.
•	Loaded the dataset into the table using the LOAD DATA LOCAL INFILE command, skipping the header row and handling CSV-specific formatting (e.g., fields terminated by commas, enclosed by quotes).
2. Data Cleaning
•	Verified Data Integrity: Confirmed 9,993 rows were loaded (excluding the header) and checked the first 10 rows against the original CSV to ensure accuracy.
•	Null Value Check: Queried all columns to confirm no null values existed.
•	Negative Profit Handling: Identified 1,871 rows with negative profit, added an is_loss BOOLEAN column to flag these entries, and updated the table accordingly.
•	Duplicate Removal: Created a new table (cleaned_sales_performance_dashboard) with distinct rows, reducing the row count to 9,976. Dropped the original table and renamed the cleaned table.
•	Column Renaming: Renamed the Sub-Category column to Sub_Category for consistency.
•	Result: A clean dataset with 9,976 rows, no duplicates, no null values, and a new is_loss column for loss analysis.
3. Exploratory Data Analysis (EDA)
Performed SQL queries to extract insights for dashboarding:
1.	Total Sales by Region:
o	West: $725,012.58
o	East: $678,435.32
o	Central: $500,782.85
o	South: $391,721.90
2.	Profit by Category:
o	Technology: $145,455.66
o	Office Supplies: $122,291.80
o	Furniture: $18,421.79
3.	Sales by Segment:
o	Consumer: $1,160,589.61
o	Corporate: $706,070.21
o	Home Office: $429,292.83
4.	Top 10 Cities by Sales:
o	New York City: $256,319.00
o	Los Angeles: $175,831.89
o	Seattle: $119,460.28
o	... (7 more cities)
5.	Profit by Category and Sub-Category:
o	Highlighted loss-making sub-categories (e.g., Tables: -$17,725.59, Bookcases: -$3,472.56).
6.	Total Profit by State:
o	California: $76,258.05
o	New York: $74,015.55
o	... (47 more states, with some showing negative profits, e.g., Texas: -$25,750.91)
7.	Total Quantity Sold by Region:
o	West: 12,232 units
o	East: 10,609 units
o	Central: 8,768 units
o	South: 6,209 units
8.	Total Quantity Sold by Category:
o	Office Supplies: 22,859 units
o	Furniture: 8,020 units
o	Technology: 6,939 units
9.	Average Quantity Sold by Segment:
o	Corporate: 3.84 units
o	Home Office: 3.78 units
o	Consumer: 3.76 units
4. Data Export
•	Attempted to export the cleaned dataset using MySQL's INTO OUTFILE command but encountered Error 1290 (--secure-file-priv restriction).
•	Resolved by writing a Python script using Pandas and mysql.connector to fetch the data and export it to Cleaned_SampleSuperstore_Export.csv.
5. Power BI Dashboard
•	Imported the cleaned CSV into Power BI.
•	Created visualizations based on EDA results, including:
o	Pie chart: Total sales by region.
o	Bar chart: Profit by category.
o	Bar chart: Sales by segment.
o	Table/Bar chart: Top 10 cities by sales.
o	Stacked bar chart: Profit by category and sub-category.
o	Bar chart: Total profit by state.
o	Bar chart: Total quantity sold by region.
o	Bar chart: Total quantity sold by category.
o	KPI card: Average quantity sold by segment.
•	Added filters for interactive exploration (e.g., by region, category, or segment).
•	Ensured clear labels, consistent formatting, and a professional layout.
Dashboard Screenshots
(To be added: Upload Power BI dashboard screenshots here once created. Ensure images are stored in a /screenshots folder in the repository for reference.)
Tools and Technologies
•	MySQL: Database management and data cleaning.
•	Python: Pandas for data export, mysql.connector for database connectivity.
•	Power BI: Dashboard creation and visualization.
•	CSV: Data storage and transfer.
•	GitHub: Project documentation and version control.
Challenges and Solutions
•	Challenge: MySQL INTO OUTFILE failed due to --secure-file-priv.
o	Solution: Used Python (Pandas) to export the data to CSV.
•	Challenge: Potential data quality issues (duplicates, negative profits).
o	Solution: Removed duplicates using SELECT DISTINCT and flagged negative profits with an is_loss column.
•	Challenge: Ensuring data integrity during CSV import.
o	Solution: Used LOAD DATA LOCAL INFILE with proper field and line terminators, verified data with SQL queries.
Future Improvements
•	Advanced Analytics: Incorporate predictive modeling (e.g., using Python or R) to forecast sales trends.
•	Automation: Automate data cleaning and export processes using Python scripts or ETL tools.
•	Enhanced Visualizations: Add advanced Power BI features like drill-throughs or custom visuals.
•	Scalability: Optimize SQL queries for larger datasets and explore cloud-based databases (e.g., AWS RDS).
How to Run the Project
1.	Set up MySQL:
o	Install MySQL and enable local_infile (SET GLOBAL local_infile = 1).
o	Create the superstore_project database and load the dataset using the provided SQL script (create_table.sql).
2.	Run SQL Queries:
o	Execute the SQL queries in data_cleaning.sql and eda.sql to clean and analyze the data.
3.	Export Data:
o	Use the Python script (export_data.py) to export the cleaned data to CSV.
4.	Create Dashboard:
o	Import the CSV into Power BI and recreate the dashboard using the provided visualizations.
5.	View Dashboard:
o	Open the Power BI file (sales_dashboard.pbix) or view screenshots in the /screenshots folder.

![image](https://github.com/user-attachments/assets/5208b223-0f33-40d5-a522-2a68e62ac1ce)
