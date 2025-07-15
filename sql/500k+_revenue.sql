-- now lets do some more edas to look for opportunities to make revenue more than 500k


-- 1. Identifying underperforming sub categorie with high sales but low or negative profit

SELECT 
    Category, 
    Sub_Category, 
    ROUND(SUM(Sales), 2) AS total_sales, 
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS profit_margin,
    COUNT(*) AS transaction_count
FROM sales_performance_dashboard
WHERE Sales > 0
GROUP BY Category, Sub_Category
HAVING total_profit < 0 AND profit_margin < 5
ORDER BY total_sales DESC;


+-----------------+--------------+-------------+--------------+---------------+-------------------+
| Category        | Sub_Category | total_sales | total_profit | profit_margin | transaction_count |
+-----------------+--------------+-------------+--------------+---------------+-------------------+
| Furniture       | Tables       |   206965.68 |    -17725.59 |         -8.56 |               319 |
| Furniture       | Bookcases    |   114880.05 |     -3472.56 |         -3.02 |               228 |
| Office Supplies | Supplies     |    46673.52 |     -1188.99 |         -2.55 |               190 |
+-----------------+--------------+-------------+--------------+---------------+-------------------+
3 rows in set (0.04 sec)



-- as we can see here thatsub categories like tables, bookcases and supplies are the ones
--who have high sales but in real they are loss making sub categories.

-- so to change these categories from loss making sub categories to profit making sub categorries we
-- can reduce the discount and check if we can recover the losses

--now lets analyze the discount given in this sub categories and then we will see if we can rediuce 
-- the dicount and make any profit by doing so

SELECT 
    category,
    Sub_Category, 
    Discount, 
    COUNT(*) AS transaction_count, 
    ROUND(AVG(Sales), 2) AS avg_sales, 
    ROUND(AVG(Profit), 2) AS avg_profit
FROM sales_performance_dashboard
WHERE Sub_Category IN ('Tables', 'Bookcases','Supplies') AND is_loss = TRUE
GROUP BY category, Sub_Category, Discount
ORDER BY Sub_Category, Discount DESC;


+-----------------+--------------+----------+-------------------+-----------+------------+
| category        | Sub_Category | Discount | transaction_count | avg_sales | avg_profit |
+-----------------+--------------+----------+-------------------+-----------+------------+
| Furniture       | Bookcases    |     0.70 |                15 |    163.96 |    -259.66 |
| Furniture       | Bookcases    |     0.50 |                18 |    406.03 |    -236.44 |
| Furniture       | Bookcases    |     0.32 |                27 |    536.79 |     -88.56 |
| Furniture       | Bookcases    |     0.30 |                 9 |    453.77 |     -61.76 |
| Furniture       | Bookcases    |     0.20 |                23 |    602.01 |     -31.56 |
| Furniture       | Bookcases    |     0.15 |                17 |    345.95 |     -19.34 |
| Office Supplies | Supplies     |     0.20 |                33 |    426.28 |     -91.38 |
| Furniture       | Tables       |     0.50 |                36 |    379.86 |    -239.32 |
| Furniture       | Tables       |     0.45 |                11 |    498.63 |    -226.65 |
| Furniture       | Tables       |     0.40 |                75 |    608.19 |    -215.83 |
| Furniture       | Tables       |     0.30 |                50 |    468.89 |     -69.30 |
| Furniture       | Tables       |     0.20 |                31 |    540.63 |     -53.26 |
+-----------------+--------------+----------+-------------------+-----------+------------+
12 rows in set (0.02 sec)


-- now lets check if we can increase the profit by reducing the discount



-- lets check all gthe sub categories first then lets look for distinct sub categories

select distinct sub_category, avg(sales) as Avg_sales, round(avg(profit),2) as Avg_Profit
from sales_performance_dashboard
where is_loss = 1
group by Sub_Category;


+--------------+-------------+------------+
| sub_category | Avg_sales   | Avg_Profit |
+--------------+-------------+------------+
| Tables       |  517.136355 |    -159.67 |
| Appliances   |   50.484776 |    -128.80 |
| Binders      |   59.047614 |     -62.92 |
| Chairs       |  391.910769 |     -42.17 |
| Bookcases    |  441.034404 |    -111.49 |
| Furnishings  |   76.921018 |     -38.87 |
| Storage      |  235.211491 |     -39.91 |
| Accessories  |  120.426813 |     -10.23 |
| Phones       |  263.219485 |     -55.37 |
| Machines     | 1646.733864 |    -684.52 |
| Supplies     |  426.278182 |     -91.38 |
| Fasteners    |   12.438333 |      -2.77 |
+--------------+-------------+------------+
12 rows in set (0.05 sec)


--a. lets analyze current loss making transactions for tables 


SELECT 
    Sub_Category,
    Discount,
    COUNT(*) AS transaction_count,
    ROUND(AVG(Sales), 2) AS avg_sales,
    ROUND(AVG(Profit), 2) AS avg_profit,
    ROUND(SUM(Profit), 2) AS total_profit
FROM sales_performance_dashboard
WHERE Sub_Category = 'Tables' AND Discount = 0.45 AND is_loss = TRUE
GROUP BY Sub_Category, Discount;


+--------------+----------+-------------------+-----------+------------+--------------+
| Sub_Category | Discount | transaction_count | avg_sales | avg_profit | total_profit |
+--------------+----------+-------------------+-----------+------------+--------------+
| Tables       |     0.45 |                11 |    498.63 |    -226.65 |     -2493.12 |
+--------------+----------+-------------------+-----------+------------+--------------+
1 row in set (0.06 sec)



-- lets decrease discount and check some other sub categories also using same concept 


SELECT 
    Sub_Category,
    Discount,
    COUNT(*) AS transaction_count,
    ROUND(AVG(Sales), 2) AS avg_sales,
    ROUND(AVG(Profit), 2) AS avg_profit,
    ROUND(SUM(Profit), 2) AS total_profit
FROM sales_performance_dashboard
WHERE Sub_Category = 'Bookcases' AND discount = 0.50 AND is_loss = 1
GROUP BY Sub_Category, Discount;



+--------------+----------+-------------------+-----------+------------+--------------+
| Sub_Category | Discount | transaction_count | avg_sales | avg_profit | total_profit |
+--------------+----------+-------------------+-----------+------------+--------------+
| Bookcases    |     0.50 |                18 |    406.03 |    -236.44 |     -4255.83 |
+--------------+----------+-------------------+-----------+------------+--------------+
1 row in set (0.04 sec)




-- now lets decrease the discount for sub category TABLE and check if we can make profit here 

WITH Adjusted_Discount AS (
    SELECT 
        Sub_Category,
        Discount AS original_discount,
        0.10 AS new_discount,
        Sales,
        Profit,
        (Sales * (1 - 0.50)) AS implied_revenue_before_cost,
        (Sales * (1 - 0.10)) - ((Sales * (1 - 0.50)) - Profit) AS new_profit
    FROM sales_performance_dashboard
    WHERE Sub_Category = 'Bookcases' AND Discount = 0.50 AND is_loss = TRUE
)
SELECT 
    Sub_Category,
    original_discount,
    new_discount,
    COUNT(*) AS transaction_count,
    ROUND(AVG(Sales), 2) AS avg_sales,
    ROUND(AVG(Profit), 2) AS original_avg_profit,
    ROUND(AVG(new_profit), 2) AS new_avg_profit,
    ROUND(SUM(new_profit), 2) AS total_new_profit
FROM Adjusted_Discount
GROUP BY Sub_Category, original_discount, new_discount;


+--------------+-------------------+--------------+-------------------+-----------+---------------------+----------------+------------------+
| Sub_Category | original_discount | new_discount | transaction_count | avg_sales | original_avg_profit | new_avg_profit | total_new_profit |
+--------------+-------------------+--------------+-------------------+-----------+---------------------+----------------+------------------+
| Bookcases    |              0.50 |         0.10 |                18 |    406.03 |             -236.44 |         -74.02 |         -1332.44 |
+--------------+-------------------+--------------+-------------------+-----------+---------------------+----------------+------------------+
1 row in set (0.02 sec)



-- as we can see even after giving less discounts in this sub category we are not able to make profit in this category
-- som lets move on to some other sub category and check if they have more transaction count so that
-- we can get convert loss to good profit 



-- fist lets list all the sub categories with their transaction count and then take one sub category 
-- which has most transaction count chekc if we can convert its loss to profit 


select
    sub_category,
    discount,
    count(*) as transaction_count,
    Round(sum(profit),2) as total_profit
from sales_performance_dashboard
group by Sub_Category, discount;


+--------------+----------+-------------------+-------------+
| sub_category | discount | transaction_count | total_sales |
+--------------+----------+-------------------+-------------+
| Bookcases    |     0.00 |                60 |     6075.75 |
| Chairs       |     0.00 |               132 |    21898.00 |
| Labels       |     0.00 |               238 |     4402.17 |
| Tables       |     0.45 |                11 |    -2493.12 |
| Storage      |     0.20 |               316 |    -4249.36 |
| Furnishings  |     0.00 |               570 |    16841.62 |
| Art          |     0.00 |               497 |     5377.53 |
| Phones       |     0.20 |               469 |    16536.84 |
| Binders      |     0.20 |               573 |    29417.80 |
| Appliances   |     0.00 |               270 |    23110.82 |
| Tables       |     0.20 |                71 |     -303.58 |
| Paper        |     0.20 |               509 |     8693.48 |
| Appliances   |     0.80 |                67 |    -8629.67 |
| Binders      |     0.80 |               232 |   -21903.22 |
| Storage      |     0.00 |               530 |    25528.41 |
| Chairs       |     0.30 |               157 |    -6725.13 |
| Tables       |     0.00 |                72 |    13276.27 |
| Accessories  |     0.00 |               471 |    35289.33 |
| Bookcases    |     0.50 |                18 |    -4255.83 |
| Binders      |     0.70 |               380 |   -16601.18 |
| Furnishings  |     0.20 |               248 |     2155.85 |
| Envelopes    |     0.20 |               102 |     1987.19 |
| Art          |     0.20 |               298 |     1147.25 |
| Furnishings  |     0.60 |               138 |    -5944.64 |
| Bookcases    |     0.32 |                27 |    -2391.16 |
| Binders      |     0.00 |               337 |    39314.48 |
| Phones       |     0.00 |               311 |    34365.24 |
| Fasteners    |     0.00 |               128 |      652.20 |
| Paper        |     0.00 |               850 |    25250.54 |
| Chairs       |     0.10 |                76 |     7111.03 |
| Chairs       |     0.20 |               250 |     4283.21 |
| Accessories  |     0.20 |               304 |     6647.45 |
| Fasteners    |     0.20 |                89 |      297.33 |
| Envelopes    |     0.00 |               152 |     4976.91 |
| Tables       |     0.50 |                36 |    -8615.44 |
| Phones       |     0.40 |               109 |    -6385.83 |
| Supplies     |     0.00 |               117 |     1718.45 |
| Appliances   |     0.20 |               112 |     2497.88 |
| Machines     |     0.40 |                13 |    -2666.85 |
| Labels       |     0.20 |               125 |     1124.14 |
| Supplies     |     0.20 |                73 |    -2907.44 |
| Bookcases    |     0.20 |                46 |      130.50 |
| Machines     |     0.70 |                23 |   -19579.35 |
| Machines     |     0.00 |                29 |    27137.84 |
| Copiers      |     0.20 |                37 |    17878.73 |
| Tables       |     0.30 |                54 |    -3402.32 |
| Copiers      |     0.00 |                22 |    35556.17 |
| Bookcases    |     0.15 |                52 |     1418.98 |
| Machines     |     0.30 |                 5 |      326.04 |
| Tables       |     0.40 |                75 |   -16187.40 |
| Appliances   |     0.10 |                16 |     1086.09 |
| Machines     |     0.50 |                12 |    -7635.24 |
| Machines     |     0.10 |                 2 |      832.09 |
| Machines     |     0.20 |                31 |     4970.20 |
| Copiers      |     0.40 |                 9 |     2183.00 |
| Bookcases    |     0.70 |                15 |    -3894.93 |
| Bookcases    |     0.30 |                10 |     -555.87 |
+--------------+----------+-------------------+-------------+




-- now lets filter this and keep only those profit which is less than 0 



 select
    sub_category,
    discount,
    count(*) as transaction_count,
    Round(sum(profit),2) as total_profit
from sales_performance_dashboard
group by Sub_Category, discount
having sum(profit) < 0
order by total_profit asc;


+--------------+----------+-------------------+--------------+
| sub_category | discount | transaction_count | total_profit |
+--------------+----------+-------------------+--------------+
| Binders      |     0.80 |               232 |    -21903.22 |
| Machines     |     0.70 |                23 |    -19579.35 |
| Binders      |     0.70 |               380 |    -16601.18 |
| Tables       |     0.40 |                75 |    -16187.40 |
| Appliances   |     0.80 |                67 |     -8629.67 |
| Tables       |     0.50 |                36 |     -8615.44 |
| Machines     |     0.50 |                12 |     -7635.24 |
| Chairs       |     0.30 |               157 |     -6725.13 |
| Phones       |     0.40 |               109 |     -6385.83 |
| Furnishings  |     0.60 |               138 |     -5944.64 |
| Bookcases    |     0.50 |                18 |     -4255.83 |
| Storage      |     0.20 |               316 |     -4249.36 |
| Bookcases    |     0.70 |                15 |     -3894.93 |
| Tables       |     0.30 |                54 |     -3402.32 |
| Supplies     |     0.20 |                73 |     -2907.44 |
| Machines     |     0.40 |                13 |     -2666.85 |
| Tables       |     0.45 |                11 |     -2493.12 |
| Bookcases    |     0.32 |                27 |     -2391.16 |
| Bookcases    |     0.30 |                10 |      -555.87 |
| Tables       |     0.20 |                71 |      -303.58 |
+--------------+----------+-------------------+--------------+




-- now lets try decreasing the discount given and see if we can get some profit in some sub categories
-- where the loss is maximum


WITH Adjusted_Discount AS (
    SELECT 
        Sub_Category,
        Discount AS original_discount,
        0.40 AS new_discount,
        Sales,
        Profit,
        (Sales * (1 - 0.80)) AS implied_revenue_before_cost,
        (Sales * (1 - 0.40)) - ((Sales * (1 - 0.80)) - Profit) AS new_profit
    FROM sales_performance_dashboard
    WHERE Sub_Category = 'Binders' AND Discount = 0.80 AND is_loss = TRUE
)
SELECT 
    Sub_Category,
    original_discount,
    new_discount,
    COUNT(*) AS transaction_count,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS original_profit,
    ROUND(AVG(new_profit), 2) AS new_avg_profit,
    ROUND(SUM(new_profit), 2) AS total_new_profit,
    ROUND(SUM(new_profit) - SUM(Profit), 2) AS difference_in_profit
FROM Adjusted_Discount
GROUP BY Sub_Category, original_discount, new_discount;


+--------------+-------------------+--------------+-------------------+-------------+-----------------+----------------+------------------+----------------------+
| Sub_Category | original_discount | new_discount | transaction_count | total_sales | original_profit | new_avg_profit | total_new_profit | difference_in_profit |
+--------------+-------------------+--------------+-------------------+-------------+-----------------+----------------+------------------+----------------------+
| Binders      |              0.80 |         0.40 |               232 |    13577.64 |       -21903.22 |         -71.00 |        -16472.16 |              5431.06 |
+--------------+-------------------+--------------+-------------------+-------------+-----------------+----------------+------------------+----------------------+
1 row in set (0.01 sec)




-- here we can see after giving less discount we get more than 5k difference in loss 
--(we are losing less money) and here we can save more 

-- I will try for more sub categories as well where pofit is less than 0





---earlier I tried for one category and checked if after decreasing discount given we can recover the loss
-- incurrend in this sub category and as we saw earlier we recovered some loss

-- so now lets try decreasing the discount for all the sub catefgories and check if we can recover the loss we incurred earlier 

WITH Adjusted_Discounts AS (
    SELECT 
        Sub_Category,
        Discount AS original_discount,
        CASE 
           WHEN Discount = 0.80 THEN 0.30
                WHEN Discount = 0.70 THEN 0.27
                WHEN Discount = 0.60 THEN 0.25
                WHEN Discount = 0.50 THEN 0.22
                WHEN Discount = 0.40 THEN 0.18
                WHEN Discount = 0.30 THEN 0.12
                WHEN Discount = 0.20 THEN 0.07
                ELSE Discount -- Keep original discount if no specific rule applies
        END AS new_discount,
        Sales,
        Profit,
        (Sales * (1 - Discount)) AS implied_revenue_before_cost,
        (Sales * (1 - 
            CASE 
                WHEN Discount = 0.80 THEN 0.30
                WHEN Discount = 0.70 THEN 0.27
                WHEN Discount = 0.60 THEN 0.25
                WHEN Discount = 0.50 THEN 0.22
                WHEN Discount = 0.40 THEN 0.18
                WHEN Discount = 0.30 THEN 0.12
                WHEN Discount = 0.20 THEN 0.07
                ELSE Discount
            END)) - ((Sales * (1 - Discount)) - Profit) AS new_profit
    FROM sales_performance_dashboard
    WHERE is_loss = 1 
)
SELECT 
    Sub_Category,
    original_discount,
    new_discount,
    COUNT(*) AS transaction_count,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS original_profit,
    ROUND(SUM(new_profit), 2) AS total_new_profit,
    ROUND(SUM(new_profit) - SUM(Profit), 2) AS difference_in_profit
FROM Adjusted_Discounts
GROUP BY Sub_Category, original_discount, new_discount
ORDER BY difference_in_profit DESC;



+--------------+-------------------+--------------+-------------------+-------------+-----------------+------------------+----------------------+
| Sub_Category | original_discount | new_discount | transaction_count | total_sales | original_profit | total_new_profit | difference_in_profit |
+--------------+-------------------+--------------+-------------------+-------------+-----------------+------------------+----------------------+
| Chairs       |              0.30 |         0.12 |               147 |    63167.54 |        -6725.13 |          4645.03 |             11370.16 |
| Machines     |              0.50 |         0.22 |                12 |    37935.09 |        -7635.24 |          2986.59 |             10621.83 |
| Tables       |              0.40 |         0.18 |                75 |    45614.40 |       -16187.40 |         -6152.23 |             10035.17 |
| Binders      |              0.70 |         0.27 |               380 |    22559.50 |       -16601.18 |         -6900.60 |              9700.59 |
| Phones       |              0.40 |         0.18 |                97 |    31979.19 |        -6715.83 |           319.59 |              7035.42 |
| Binders      |              0.80 |         0.30 |               232 |    13577.64 |       -21903.22 |        -15114.40 |              6788.82 |
| Machines     |              0.70 |         0.27 |                23 |    15601.53 |       -19579.35 |        -12870.69 |              6708.66 |
| Storage      |              0.20 |         0.07 |               161 |    37869.05 |        -6426.31 |         -1503.33 |              4922.98 |
| Tables       |              0.30 |         0.12 |                50 |    23444.70 |        -3465.22 |           754.83 |              4220.05 |
| Machines     |              0.40 |         0.18 |                 8 |    17556.77 |        -2884.66 |           977.83 |              3862.49 |
| Tables       |              0.50 |         0.22 |                36 |    13675.09 |        -8615.44 |         -4786.41 |              3829.03 |
| Chairs       |              0.20 |         0.07 |                83 |    27033.24 |        -3114.48 |           399.84 |              3514.32 |
| Furnishings  |              0.60 |         0.25 |               138 |     6644.68 |        -5944.64 |         -3619.00 |              2325.64 |
| Tables       |              0.20 |         0.07 |                31 |    16759.51 |        -1651.06 |           527.68 |              2178.74 |
| Bookcases    |              0.50 |         0.22 |                18 |     7308.47 |        -4255.83 |         -2209.46 |              2046.37 |
| Supplies     |              0.20 |         0.07 |                33 |    14067.18 |        -3015.62 |         -1186.89 |              1828.73 |
| Bookcases    |              0.20 |         0.07 |                23 |    13846.34 |         -725.77 |          1074.25 |              1800.02 |
| Appliances   |              0.80 |         0.30 |                67 |     3382.48 |        -8629.67 |         -6938.43 |              1691.24 |
| Accessories  |              0.20 |         0.07 |                91 |    10958.84 |         -930.65 |           494.00 |              1424.65 |
| Bookcases    |              0.70 |         0.27 |                15 |     2459.37 |        -3894.93 |         -2837.40 |              1057.53 |
| Furnishings  |              0.20 |         0.07 |                29 |     6201.13 |         -546.26 |           259.89 |               806.15 |
| Bookcases    |              0.30 |         0.12 |                 9 |     4083.95 |         -555.87 |           179.24 |               735.11 |
| Phones       |              0.20 |         0.07 |                39 |     3818.66 |         -814.84 |          -318.41 |               496.43 |
| Machines     |              0.30 |         0.12 |                 1 |     1362.90 |          -19.47 |           225.85 |               245.32 |
| Fasteners    |              0.20 |         0.07 |                12 |      149.26 |          -33.19 |           -13.79 |                19.40 |
| Bookcases    |              0.15 |         0.15 |                17 |     5881.17 |         -328.74 |          -328.74 |                 0.00 |
| Bookcases    |              0.32 |         0.32 |                27 |    14493.45 |        -2391.16 |         -2391.16 |                 0.00 |
| Chairs       |              0.10 |         0.10 |                 4 |     1506.34 |          -29.28 |           -29.28 |                 0.00 |
| Tables       |              0.45 |         0.45 |                11 |     5484.98 |        -2493.12 |         -2493.12 |                 0.00 |
+--------------+-------------------+--------------+-------------------+-------------+-----------------+------------------+----------------------+
29 rows in set (0.15 sec)







