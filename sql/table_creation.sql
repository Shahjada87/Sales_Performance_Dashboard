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

select  category, Round(sum(profit),2)as profit_by_category
from sales_performance_dashboard
group by category
order by profit_by_category desc; asc

+-----------------+--------------------+
| category        | profit_by_category |
+-----------------+--------------------+
| Technology      |          145455.66 |
| Office Supplies |          122291.80 |
| Furniture       |           18421.79 |
+-----------------+--------------------+
3 rows in set (0.02 sec)



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


5. Profit by category and sub category


select  category,Sub_Category, Round(sum(profit),2)as profit_by_category
from sales_performance_dashboard
group by category, Sub_Category
order by profit_by_category;


+-----------------+--------------+--------------------+
| category        | Sub_Category | profit_by_category |
+-----------------+--------------+--------------------+
| Furniture       | Tables       |          -17725.59 |
| Furniture       | Bookcases    |           -3472.56 |
| Office Supplies | Supplies     |           -1188.99 |
| Office Supplies | Fasteners    |             949.53 |
| Technology      | Machines     |            3384.73 |
| Office Supplies | Labels       |            5526.31 |
| Office Supplies | Art          |            6524.78 |
| Office Supplies | Envelopes    |            6964.10 |
| Furniture       | Furnishings  |           13052.83 |
| Office Supplies | Appliances   |           18065.12 |
| Office Supplies | Storage      |           21279.05 |
| Furniture       | Chairs       |           26567.11 |
| Office Supplies | Binders      |           30227.88 |
| Office Supplies | Paper        |           33944.02 |
| Technology      | Accessories  |           41936.78 |
| Technology      | Phones       |           44516.25 |
| Technology      | Copiers      |           55617.90 |
+-----------------+--------------+--------------------+
17 rows in set (0.08 sec)




-- there are more combinations for eda(exploratory data analysis) but 
-- lets export the cleaned data to the local storage for analysis using power bi.


SELECT * FROM sales_performance_dashboard
INTO OUTFILE 
'/Users/shahjadaemirsaqualain/Downloads/Cleaned_SampleSuperstore_Export.csv'
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n';

-- I am stuck at this point. I am getting an 
-- error number 1290 which is 
--"The MySQL server is running with the --secure-file-priv option so it cannot execute this statement"
-- while trying to export the cleaned data set to my local computer.

-- very soon I will try and resolve this issue.



-- As its not working, now I am goiing to solve this using pyhton using pandas 


-- now I realised I have made a mistake while making the table.  I am going to chnage the name 
-- column from Sub-Category to sub_category

ALTER TABLE sales_performance_dashboard 
CHANGE COLUMN `Sub-Category` Sub_Category VARCHAR(50);


mysql> SELECT * FROM sales_performance_dashboard
    -> ;
+----------------+-------------+---------------+-------------------+----------------------+-------------+---------+-----------------+--------------+----------+----------+----------+----------+---------+
| Ship Mode      | Segment     | Country       | City              | State                | Postal Code | Region  | Category        | Sub_Category | Sales    | Quantity | Discount | Profit   | is_loss |
+----------------+-------------+---------------+-------------------+----------------------+-------------+---------+-----------------+--------------+----------+----------+----------+----------+---------+
| Second Class   | Consumer    | United States | Henderson         | Kentucky             | 42420       | South   | Furniture       | Bookcases    |   261.96 |        2 |     0.00 |    41.91 |       0 |
| Second Class   | Consumer    | United States | Henderson         | Kentucky             | 42420       | South   | Furniture       | Chairs       |   731.94 |        3 |     0.00 |   219.58 |       0 |
| Second Class   | Corporate   | United States | Los Angeles       | California           | 90036       | West    | Office Supplies | Labels       |    14.62 |        2 |     0.00 |     6.87 |       0 |
| Standard Class | Consumer    | United States | Fort Lauderdale   | Florida              | 33311       | South   | Furniture       | Tables       |   957.58 |        5 |     0.45 |  -383.03 |       1 |
| Standard Class | Consumer    | United States | Fort Lauderdale   | Florida              | 33311       | South   | Office Supplies | Storage      |    22.37 |        2 |     0.20 |     2.52 |       0 |


-- now lets check some more edas

-- 6. Total profit per state


SELECT State, SUM(Profit) AS total_profit
FROM sales_performance_dashboard
GROUP BY State
ORDER BY total_profit DESC;


Output 

+----------------------+--------------+
| State                | total_profit |
+----------------------+--------------+
| California           |     76258.05 |
| New York             |     74015.55 |
| Washington           |     33368.29 |
| Michigan             |     24428.05 |
| Virginia             |     18598.00 |
| Indiana              |     18382.97 |
| Georgia              |     16250.08 |
| Kentucky             |     11199.70 |
| Minnesota            |     10823.22 |
| Delaware             |      9977.37 |
| New Jersey           |      9772.91 |
| Wisconsin            |      8401.78 |
| Rhode Island         |      7285.64 |
| Maryland             |      7031.20 |
| Massachusetts        |      6785.55 |
| Missouri             |      6436.19 |
| Alabama              |      5786.85 |
| Oklahoma             |      4853.98 |
| Arkansas             |      4008.65 |
| Connecticut          |      3511.44 |
| Nevada               |      3316.76 |
| Mississippi          |      3172.98 |
| Utah                 |      2546.56 |
| Vermont              |      2244.98 |
| Louisiana            |      2196.09 |
| Nebraska             |      2037.10 |
| Montana              |      1833.32 |
| South Carolina       |      1769.08 |
| New Hampshire        |      1706.50 |
| Iowa                 |      1183.81 |
| New Mexico           |      1157.13 |
| District of Columbia |      1059.59 |
| Kansas               |       836.45 |
| Idaho                |       826.73 |
| Maine                |       454.50 |
| South Dakota         |       394.84 |
| North Dakota         |       230.14 |
| West Virginia        |       185.93 |
| Wyoming              |       100.20 |
| Oregon               |     -1194.11 |
| Florida              |     -3399.25 |
| Arizona              |     -3427.87 |
| Tennessee            |     -5341.66 |
| Colorado             |     -6527.86 |
| North Carolina       |     -7490.81 |
| Illinois             |    -12601.65 |
| Pennsylvania         |    -15565.48 |
| Ohio                 |    -16959.31 |
| Texas                |    -25750.91 |
+----------------------+--------------+
49 rows in set (0.06 sec)




--7.  Total quantity sold per region


SELECT Region, SUM(Quantity) AS total_quantity
FROM sales_performance_dashboard
GROUP BY Region
ORDER BY total_quantity DESC;

Output

+---------+----------------+
| Region  | total_quantity |
+---------+----------------+
| West    |          12232 |
| East    |          10609 |
| Central |           8768 |
| South   |           6209 |
+---------+----------------+
4 rows in set (0.02 sec)


--8. Total quantity sold per product category


SELECT Category, SUM(Quantity) AS total_quantity
FROM sales_performance_dashboard
GROUP BY Category
ORDER BY total_quantity DESC;


Output

+-----------------+----------------+
| Category        | total_quantity |
+-----------------+----------------+
| Office Supplies |          22859 |
| Furniture       |           8020 |
| Technology      |           6939 |
+-----------------+----------------+
3 rows in set (0.02 sec)




--9.  Average quantity sold per customer segment
SELECT Segment, AVG(Quantity) AS avg_quantity
FROM sales_performance_dashboard
GROUP BY Segment
ORDER BY avg_quantity DESC;


Output 


+-------------+--------------+
| Segment     | avg_quantity |
+-------------+--------------+
| Corporate   |       3.8444 |
| Home Office |       3.7841 |
| Consumer    |       3.7621 |
+-------------+--------------+
3 rows in set (0.01 sec)






