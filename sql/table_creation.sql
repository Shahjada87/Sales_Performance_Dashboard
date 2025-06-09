
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
| Standard Class | Consumer    | United States | Fort Lauderdale   | Florida              | 33311       | South   | Furniture       | Tables       |   957.58 |        5 |     0.45 |  -383.03 |
| Standard Class | Consumer    | United States | Fort Lauderdale   | Florida              | 33311       | South   | Office Supplies | Storage      |    22.37 |        2 |     0.20 |     2.52 |
| Standard Class | Consumer    | United States | Los Angeles       | California           | 90032       | West    | Furniture       | Furnishings  |    48.86 |        7 |     0.00 |    14.17 |
| Standard Class | Consumer    | United States | Los Angeles       | California           | 90032       | West    | Office Supplies | Art          |     7.28 |        4 |     0.00 |     1.97 |
| Standard Class | Consumer    | United States | Los Angeles       | California           | 90032       | West    | Technology      | Phones       |   907.15 |        6 |     0.20 |    90.72 |
| Standard Class | Consumer    | United States | Los Angeles       | California           | 90032       | West    | Office Supplies | Binders      |    18.50 |        3 |     0.20 |     5.78 |
| Standard Class | Consumer    | United States | Los Angeles       | California           | 90032       | West    | Office Supplies | Appliances   |   114.90 |        5 |     0.00 |    34.47 |


