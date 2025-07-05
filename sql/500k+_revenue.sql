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


