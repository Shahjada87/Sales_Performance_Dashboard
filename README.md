<h1 align = center >Sales Performance Dashboard Project</h1>

<h2>Project Overview</h2>

This project focuses on analyzing sales performance data from a Superstore dataset to derive actionable business insights. 
The dataset, stored in a MySQL database, was cleaned, processed, and analyzed using SQL for data preparation and Pandas for data export. 
A comprehensive dashboard was built using Power BI to visualize key performance metrics, enabling stakeholders to make data-driven decisions.

The primary goal was to create an interactive dashboard that highlights sales, profit, and quantity metrics across various dimensions such as regions, categories, segments, and cities. 
The project demonstrates proficiency in SQL for data manipulation, Python (Pandas) for data export, and Power BI for data visualization.


<h3>Methodology</h3>


**1. Database Setup**

Created a MySQL database (superstore_project) and a table (sales_performance_dashboard) to store the dataset.


Enabled MySQL's LOCAL INFILE feature to load data from the CSV file.


Loaded the dataset using LOAD DATA LOCAL INFILE, skipping the header row and handling CSV formatting.



**2. Data Cleaning**

Verified Data Integrity: Confirmed 9,993 rows loaded and checked the first 10 rows against the original CSV.


Null Value Check: Confirmed no null values in any column.


Negative Profit Handling: Identified 1,871 rows with negative profit, added an is_loss BOOLEAN column, and flagged these entries.


Duplicate Removal: Created a new table with distinct rows (9,976 rows), dropped the original table, and renamed the cleaned table.


Column Renaming: Renamed Sub-Category to Sub_Category for consistency.



**3. Exploratory Data Analysis (EDA)**


Performed SQL queries to extract insights:


Total Sales by Region: West ($725,012.58), East ($678,435.32), Central ($500,782.85), South ($391,721.90).


Profit by Category: Technology ($145,455.66), Office Supplies ($122,291.80), Furniture ($18,421.79).


Sales by Segment: Consumer ($1,160,589.61), Corporate ($706,070.21), Home Office ($429,292.83).


Top 10 Cities by Sales: New York City ($256,319.00), Los Angeles ($175,831.89), etc.


Profit by Category and Sub-Category: Identified loss-making sub-categories (e.g., Tables: -$17,725.59).


Total Profit by State: California ($76,258.05), New York ($74,015.55), etc.


Total Quantity Sold by Region: West (12,232 units), East (10,609 units), etc.


Total Quantity Sold by Category: Office Supplies (22,859 units), Furniture (8,020 units), Technology (6,939 units).


Average Quantity Sold by Segment: Corporate (3.84 units), Home Office (3.78 units), Consumer (3.76 units).



**4. Data Export**

Attempted MySQL INTO OUTFILE but faced --secure-file-priv error.


Used Python (Pandas, mysql.connector) to export the cleaned data to Cleaned_SampleSuperstore_Export.csv.



**5. Power BI Dashboard**

Imported the cleaned CSV into Power BI.


Created visualizations based on EDA results, including pie charts, bar charts, and KPI cards.


Added interactive filters for region, category, and segment.



<h3>Key Performance Indicators (KPIs)</h3>

The following KPIs were defined to monitor sales performance and visualized in the Power BI dashboard:





**Total Sales:**





Sum of all sales revenue ($2,295,952.65).



Purpose: Measures overall revenue performance.



Visualization: KPI card.



**Total Profit:**





Sum of profit ($286,169.25).



Purpose: Evaluates profitability and identifies loss-making transactions.



Visualization: KPI card, bar charts by category/state.



**Average Sales per Transaction:**





Average sales value (~$230.20).



Purpose: Assesses transaction size.



Visualization: KPI card.



**Average Quantity Sold per Transaction:**





Average items sold per transaction (~3.79 units).



Purpose: Measures sales volume efficiency.



Visualization: KPI card, bar chart by segment.



**Profit Margin:**





Ratio of profit to sales (~12.46%).



Purpose: Evaluates profitability efficiency.



Visualization: KPI card or gauge.



**Loss-Making Transactions:**





Count of transactions with negative profit (1,871).



Purpose: Identifies unprofitable sales.



Visualization: KPI card or filtered table.



**Top-Performing Region by Sales:**





Region with highest sales (West: $725,012.58).



Purpose: Identifies lucrative markets.



Visualization: Pie chart or map.



**Top-Performing Category by Profit:**





Category with highest profit (Technology: $145,455.66).



Purpose: Identifies profitable product lines.



Visualization: Bar chart or treemap.

---

<h4>Dashboard Screenshots</h4>


<img align = center width="617" alt="Screenshot 2025-06-27 at 12 24 13 PM" src="https://github.com/user-attachments/assets/5a33c8ec-f23a-4dd2-b533-76aae3d46167" />


<img width="1014" alt="Screenshot 2025-06-29 at 4 52 02 PM" src="https://github.com/user-attachments/assets/e63dafac-2ae4-4231-b0d5-67158e9e7d07" />


<img width="1285" alt="Screenshot 2025-07-01 at 4 04 44 PM" src="https://github.com/user-attachments/assets/f20ef273-e198-4e73-bd50-c4535a97aecd" />


---


<h4>Tools and Technologies</h4>

•	MySQL: Database management and data cleaning.

•	Python: Pandas for data export, mysql.connector for database connectivity.

•	Power BI: Dashboard creation and visualization.

•	CSV: Data storage and transfer.

•	GitHub: Project documentation and version control.

<h4>Challenges and Solutions</h4>

•	Challenge: MySQL INTO OUTFILE failed due to --secure-file-priv.

o	Solution: Used Python (Pandas) to export the data to CSV.

•	Challenge: Potential data quality issues (duplicates, negative profits).

o	Solution: Removed duplicates using SELECT DISTINCT and flagged negative profits with an is_loss column.

•	Challenge: Ensuring data integrity during CSV import.

o	Solution: Used LOAD DATA LOCAL INFILE with proper field and line terminators, verified data with SQL queries.

<h4>Future Improvements</h4>

•	Advanced Analytics: Incorporate predictive modeling (e.g., using Python or R) to forecast sales trends.

•	Automation: Automate data cleaning and export processes using Python scripts or ETL tools.

•	Enhanced Visualizations: Add advanced Power BI features like drill-throughs or custom visuals.

•	Scalability: Optimize SQL queries for larger datasets and explore cloud-based databases (e.g., AWS RDS).

<h4>How to Run the Project</h4>

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
