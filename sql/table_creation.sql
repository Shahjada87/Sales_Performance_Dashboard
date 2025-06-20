-- Active: 1739013567819@@127.0.0.1@3306@superstore_project

create database superstore_project;

use superstore_project;


create table if not exists sales_performance_dashboard(
    `Ship Mode` VARCHAR(50),
    Segment VARCHAR(50),
    Country VARCHAR(100),
    City VARCHAR(100),
    State VARCHAR(100),
    `Postal Code` VARCHAR(20),
    Region VARCHAR(50),
    Category VARCHAR(50),
    `Sub-Category` VARCHAR(50),
    Sales DECIMAL(10,2),
    Quantity INT,
    Discount DECIMAL(5,2),
    Profit DECIMAL(10,2)
);



-- this enables the LOCAL INFILE feature in MySQL, 
--which allows the server to read data files from the local file system.
Set global local_infile = 1;


-- now lets add data from local to the table that I just now created using the 
--load data query
LOAD DATA LOCAL INFILE 
'/Users/shahjadaemirsaqualain/Downloads/SampleSuperstore.csv' 
INTO TABLE sales_performance_dashboard

Select * from sales_performance_dashboard;

delete from sales_performance_dashboard


-- As I got all the rows as null entry so trying to get the actual
-- data into the table using the correct load data query

--so here I have used some condition to check while loading the data

--FIELDS TERMINATED BY ',':: means commas (,) as the separator between columns in the CSV file.
--ENCLOSED BY '"':: means that field values may be wrapped in double quotes (") to handle commas or special characters within data.
--LINES TERMINATED BY '\n':: means that each row ends with a newline character (\n), marking the end of a record.
--IGNORE 1 ROWS:: Skips the first row (usually the header) during data loading into the table.

LOAD DATA LOCAL INFILE 
'/Users/shahjadaemirsaqualain/Downloads/SampleSuperstore.csv' 
INTO TABLE sales_performance_dashboard
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n' 
IGNORE 1 ROWS;

--sneak peak of the data 
mysql> select * from sales_performance_dashboard;
+----------------+-------------+---------------+-------------------+----------------------+-------------+---------+-----------------+--------------+----------+----------+----------+----------+
| Ship Mode      | Segment     | Country       | City              | State                | Postal Code | Region  | Category        | Sub-Category | Sales    | Quantity | Discount | Profit   |
+----------------+-------------+---------------+-------------------+----------------------+-------------+---------+-----------------+--------------+----------+----------+----------+----------+
| Second Class   | Consumer    | United States | Henderson         | Kentucky             | 42420       | South   | Furniture       | Bookcases    |   261.96 |        2 |     0.00 |    41.91 |
| Second Class   | Consumer    | United States | Henderson         | Kentucky             | 42420       | South   | Furniture       | Chairs       |   731.94 |        3 |     0.00 |   219.58 |
| Second Class   | Corporate   | United States | Los Angeles       | California           | 90036       | West    | Office Supplies | Labels       |    14.62 |        2 |     0.00 |     6.87 |





-------Now lets clean the data--------


-- 1. lets check if the table has the complete dataset loaded to it

mysql> select count(*) from sales_performance_dashboard ;
+----------+
| count(*) |
+----------+
|     9993 |
+----------+

-- it gave me a total 9993 rows of data has been loaded to the table because 
-- as this dataset contained 1st as headers so it was ignored in the load data command



-- 2. lets check the first 10 rows to confirm data integrity meaning if all the correct datas have been loaded

mysql> select * from sales_performance_dashboard limit 10;
+----------------+-----------+---------------+-----------------+------------+-------------+--------+-----------------+--------------+--------+----------+----------+---------+
| Ship Mode      | Segment   | Country       | City            | State      | Postal Code | Region | Category        | Sub-Category | Sales  | Quantity | Discount | Profit  |
+----------------+-----------+---------------+-----------------+------------+-------------+--------+-----------------+--------------+--------+----------+----------+---------+
| Second Class   | Consumer  | United States | Henderson       | Kentucky   | 42420       | South  | Furniture       | Bookcases    | 261.96 |        2 |     0.00 |   41.91 |
| Second Class   | Consumer  | United States | Henderson       | Kentucky   | 42420       | South  | Furniture       | Chairs       | 731.94 |        3 |     0.00 |  219.58 |
| Second Class   | Corporate | United States | Los Angeles     | California | 90036       | West   | Office Supplies | Labels       |  14.62 |        2 |     0.00 |    6.87 |
| Standard Class | Consumer  | United States | Fort Lauderdale | Florida    | 33311       | South  | Furniture       | Tables       | 957.58 |        5 |     0.45 | -383.03 |
| Standard Class | Consumer  | United States | Fort Lauderdale | Florida    | 33311       | South  | Office Supplies | Storage      |  22.37 |        2 |     0.20 |    2.52 |
| Standard Class | Consumer  | United States | Los Angeles     | California | 90032       | West   | Furniture       | Furnishings  |  48.86 |        7 |     0.00 |   14.17 |
| Standard Class | Consumer  | United States | Los Angeles     | California | 90032       | West   | Office Supplies | Art          |   7.28 |        4 |     0.00 |    1.97 |
| Standard Class | Consumer  | United States | Los Angeles     | California | 90032       | West   | Technology      | Phones       | 907.15 |        6 |     0.20 |   90.72 |
| Standard Class | Consumer  | United States | Los Angeles     | California | 90032       | West   | Office Supplies | Binders      |  18.50 |        3 |     0.20 |    5.78 |
| Standard Class | Consumer  | United States | Los Angeles     | California | 90032       | West   | Office Supplies | Appliances   | 114.90 |        5 |     0.00 |   34.47 |
+----------------+-----------+---------------+-----------------+------------+-------------+--------+-----------------+--------------+--------+----------+----------+---------+



-- after comaparing this with the original data in excel I found all the data that
-- is loaded here are completely correct

Ship Mode	    Segment	        Country	       City	        State    Postal Code	Region	Category	    Sub-Category	Sales	Quantity	Discount	Profit
Second Class	Consumer	United States	Henderson	    Kentucky	42420	    South	Furniture	    Bookcases	    261.96	    2	        0	    41.9136
Second Class	Consumer	United States	Henderson	    Kentucky	42420	    South	Furniture	    Chairs	        731.94	    3	        0	    219.582
Second Class	Corporate	United States	Los Angeles	    California	90036	    West	Office Supplies	Labels	        14.62	    2	        0	    6.8714
Standard Class	Consumer	United States	Fort Lauderdale	Florida	    33311	    South	Furniture	    Tables	        957.5775	5	        0.45	-383.031
Standard Class	Consumer	United States	Fort Lauderdale	Florida	    33311	    South	Office Supplies	Storage	        22.368	    2	        0.2	    2.5164
Standard Class	Consumer	United States	Los Angeles	    California	90032	    West	Furniture	    Furnishings	    48.86	    7	        0	    14.1694
Standard Class	Consumer	United States	Los Angeles	    California	90032	    West	Office Supplies	Art	            7.28	    4	        0	    1.9656
Standard Class	Consumer	United States	Los Angeles	    California	90032	    West	Technology	    Phones	        907.152	    6	        0.2	    90.7152
Standard Class	Consumer	United States	Los Angeles	    California	90032	    West	Office Supplies	Binders	        18.504	    3	        0.2	    5.7825
Standard Class	Consumer	United States	Los Angeles	    California	90032	    West	Office Supplies	Appliances	    114.9	    5	        0	    34.47

-- the above mentioned is the acrtual dataset.

-- this means load data local infile worked as expected to work


-- now lets check the data if there are any null values in the whole dataset

1.

SELECT 
COUNT(*) AS total_rows,
SUM(CASE WHEN `Ship Mode` IS NULL THEN 1 ELSE 0 END) AS null_ship_mode
FROM sales_performance_dashboard;

+------------+----------------+
| total_rows | null_ship_mode |
+------------+----------------+
|       9993 |              0 |
+------------+----------------+

-- here i have checked if any rows contained any null values in ship mode column
-- if there were any this would have checked and gave me sum of all the null vlaues


2.

select 
count(*) as total_rows,
sum(case when 'Segment' IS Not NULL then 1 else 0 end) as No_null_segment
from sales_performance_dashboard;


+------------+-----------------+
| total_rows | No_null_segment |
+------------+-----------------+
|       9993 |            9993 |
+------------+-----------------+


-- here i have twicked a little if there are none null values then it will sum all the rows and
-- if there were any this would have checked and discarded that row from the sum

3.

-- likewise lets check all the other columns in one go 


select 
count(*) as total_rows,
sum(case when 'Country' IS NULL then 1 else 0 end) as null_country,
sum(case when 'City' IS NULL then 1 else 0 end) as null_city,
sum(case when 'State' IS NULL then 1 else 0 end) as null_State,
sum(case when 'Postal Code' IS NULL then 1 else 0 end) as null_postal_code,
sum(case when 'City' IS NULL then 1 else 0 end) as null_city,
sum(case when 'Region' IS NULL then 1 else 0 end) as null_region,
sum(case when 'Category' IS NULL then 1 else 0 end) as null_category,
sum(case when 'Sub Category' IS NULL then 1 else 0 end) as null_sub_category,
sum(case when 'Sales' IS NULL then 1 else 0 end) as null_sales,
sum(case when 'Quantity' IS NULL then 1 else 0 end) as null_quantity,
sum(case when 'Discount' IS NULL then 1 else 0 end) as null_discount,
sum(case when 'Profit' IS NULL then 1 else 0 end) as null_profit
from sales_performance_dashboard;


+------------+--------------+-----------+------------+------------------+-----------+-------------+---------------+-------------------+------------+---------------+---------------+-------------+
| total_rows | null_country | null_city | null_State | null_postal_code | null_city | null_region | null_category | null_sub_category | null_sales | null_quantity | null_discount | null_profit |
+------------+--------------+-----------+------------+------------------+-----------+-------------+---------------+-------------------+------------+---------------+---------------+-------------+
|       9993 |            0 |         0 |          0 |                0 |         0 |           0 |             0 |                 0 |          0 |             0 |             0 |           0 |
+------------+--------------+-----------+------------+------------------+-----------+-------------+---------------+-------------------+------------+---------------+---------------+-------------+


-- there are none null values present in the data loaded to the table


-- now lets check if there any negative values 

select * from sales_performance_dashboard
where profit < 0 
limit 5;

+----------------+-------------+---------------+-----------------+--------------+-------------+---------+-----------------+--------------+---------+----------+----------+----------+
| Ship Mode      | Segment     | Country       | City            | State        | Postal Code | Region  | Category        | Sub-Category | Sales   | Quantity | Discount | Profit   |
+----------------+-------------+---------------+-----------------+--------------+-------------+---------+-----------------+--------------+---------+----------+----------+----------+
| Standard Class | Consumer    | United States | Fort Lauderdale | Florida      | 33311       | South   | Furniture       | Tables       |  957.58 |        5 |     0.45 |  -383.03 |
| Standard Class | Home Office | United States | Fort Worth      | Texas        | 76106       | Central | Office Supplies | Appliances   |   68.81 |        5 |     0.80 |  -123.86 |
| Standard Class | Home Office | United States | Fort Worth      | Texas        | 76106       | Central | Office Supplies | Binders      |    2.54 |        3 |     0.80 |    -3.82 |
| Second Class   | Consumer    | United States | Philadelphia    | Pennsylvania | 19140       | East    | Furniture       | Chairs       |   71.37 |        2 |     0.30 |    -1.02 |
| Standard Class | Consumer    | United States | Philadelphia    | Pennsylvania | 19140       | East    | Furniture       | Bookcases    | 3083.43 |        7 |     0.50 | -1665.05 |
+----------------+-------------+---------------+-----------------+--------------+-------------+---------+-----------------+--------------+---------+----------+----------+----------+
5 rows in set (0.04 sec)



-- as we can see there are negative values present in the data set
-- lets handle these as well now

--Adding an is_loss flag will allow to easily filter or analyze these loss-making 
--entries without repeatedly querying WHERE Profit < 0

ALTER TABLE sales_performance_dashboard 
ADD COLUMN is_loss BOOLEAN DEFAULT FALSE;


UPDATE sales_performance_dashboard 
SET is_loss = TRUE WHERE Profit < 0;


SELECT * 
FROM sales_performance_dashboard 
WHERE is_loss = TRUE LIMIT 5;


+----------------+-------------+---------------+-----------------+--------------+-------------+---------+-----------------+--------------+---------+----------+----------+----------+---------+
| Ship Mode      | Segment     | Country       | City            | State        | Postal Code | Region  | Category        | Sub-Category | Sales   | Quantity | Discount | Profit   | is_loss |
+----------------+-------------+---------------+-----------------+--------------+-------------+---------+-----------------+--------------+---------+----------+----------+----------+---------+
| Standard Class | Consumer    | United States | Fort Lauderdale | Florida      | 33311       | South   | Furniture       | Tables       |  957.58 |        5 |     0.45 |  -383.03 |       1 |
| Standard Class | Home Office | United States | Fort Worth      | Texas        | 76106       | Central | Office Supplies | Appliances   |   68.81 |        5 |     0.80 |  -123.86 |       1 |
| Standard Class | Home Office | United States | Fort Worth      | Texas        | 76106       | Central | Office Supplies | Binders      |    2.54 |        3 |     0.80 |    -3.82 |       1 |
| Second Class   | Consumer    | United States | Philadelphia    | Pennsylvania | 19140       | East    | Furniture       | Chairs       |   71.37 |        2 |     0.30 |    -1.02 |       1 |
| Standard Class | Consumer    | United States | Philadelphia    | Pennsylvania | 19140       | East    | Furniture       | Bookcases    | 3083.43 |        7 |     0.50 | -1665.05 |       1 |



-- here we can see there a total of 1871 loss making rows

SELECT COUNT(*) AS loss_rows 
FROM sales_performance_dashboard 
WHERE is_loss = TRUE;

+-----------+
| loss_rows |
+-----------+
|      1871 |
+-----------+


-- now lets remove all the duplicate entries in the data set

-- query to make a table with no duplicate entries 

create table cleaned_sales_performance_dashboard
AS select distinct * from sales_performance_dashboard;


select count(*) from cleaned_sales_performance_dashboard;
+----------+
| count(*) |
+----------+
|     9976 |
+----------+

-- now lets drop the old table which contains the duplicate entries 

drop table
sales_performance_dashboard;


-- now lets rename the cleaned table to original name 

alter table cleaned_sales_performance_dashboard
rename to sales_performance_dashboard;


-- the new table contains 9976 rows of data
-- cleaning the data will help to have the bnest data quality, missing values will
-- change the analysis and duplicate might also chaneg the analysis.

select count(*) from sales_performance_dashboard;
+----------+
| count(*) |
+----------+
|     9976 |
+----------+


-- as the data cleaning part is done now lets check if the data is good for dashboarding 

1. Total sales based of region

Select region, sum(sales) as total_sales
from sales_performance_dashboard
group by region
order by total_sales desc;


+---------+-------------+
| region  | total_sales |
+---------+-------------+
| West    |   725012.58 |
| East    |   678435.32 |
| Central |   500782.85 |
| South   |   391721.90 |
+---------+-------------+
4 rows in set (0.02 sec)


--so we got the best performing region based on the sum of total sales in the region
--this will help us get the best pie chart.


2. Profit based of category

select category, Round(sum(profit),2)as profit_by_category
from sales_performance_dashboard
group by category
order by profit_by_category desc

+-----------------+--------------------+
| category        | profit_by_category |
+-----------------+--------------------+
| Technology      |          145455.66 |
| Office Supplies |          122291.80 |
| Furniture       |           18421.79 |
+-----------------+--------------------+

-- this will also help in getting the best chart for the profit by category


3. Sales by segment

select Segment, Sum(sales) as total_sales_by_segment  
FROM sales_performance_dashboard
group by segment 
ORDER BY total_sales_by_segment desc


+-------------+------------------------+
| Segment     | total_sales_by_segment |
+-------------+------------------------+
| Consumer    |             1160589.61 |
| Corporate   |              706070.21 |
| Home Office |              429292.83 |
+-------------+------------------------+

4. Top 10 cities by sales 


select city, sum(sales) as total_sales_by_cities
from sales_performance_dashboard
GROUP BY city
ORDER BY total_sales_by_cities desc
limit 10;


+---------------+-----------------------+
| city          | total_sales_by_cities |
+---------------+-----------------------+
| New York City |             256319.00 |
| Los Angeles   |             175831.89 |
| Seattle       |             119460.28 |
| San Francisco |             112577.17 |
| Philadelphia  |             109061.54 |
| Houston       |              64441.21 |
| Chicago       |              48536.03 |
| San Diego     |              47521.05 |
| Jacksonville  |              44713.18 |
| Springfield   |              43054.35 |
+---------------+-----------------------+
10 rows in set (0.02 sec)

-- there are more combinations for eda(exploratory data analysis) but 
-- lets export the cleaned data to the local storage for analysis using power bi.


SELECT * FROM sales_performance_dashboard
INTO OUTFILE 
'/Users/abdurrehman/Downloads/Cleaned_SampleSuperstore_Export.csv'
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n';

-- I am stuck at this point. I am getting an 
-- error number 1290 which is 
--"The MySQL server is running with the --secure-file-priv option so it cannot execute this statement"
-- while trying to export the cleaned data set to my local computer.

-- very soon I will try and resolve this issue.

