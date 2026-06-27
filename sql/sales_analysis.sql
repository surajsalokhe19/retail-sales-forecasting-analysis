CREATE DATABASE superstore_db;
USE superstore_db;

SELECT * FROM superstore_cleaned LIMIT 5;
SELECT COUNT(*) FROM superstore_cleaned;

-- Business Overview

SELECT 
    COUNT(DISTINCT `Order ID`)       AS Total_Orders,
    ROUND(SUM(Sales), 2)             AS Total_Revenue,
    ROUND(SUM(Profit), 2)            AS Total_Profit,
    ROUND(AVG(`Profit Margin %`), 2) AS Avg_Profit_Margin
FROM superstore_cleaned;



-- Revenue by Category

SELECT 
    Category,
    ROUND(SUM(Sales), 2)  AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    COUNT(*)              AS Total_Orders
FROM superstore_cleaned
GROUP BY Category
ORDER BY Total_Sales DESC;


-- Profit by Region

SELECT 
    Region,
    ROUND(SUM(Sales), 2)            AS Total_Sales,
    ROUND(SUM(Profit), 2)           AS Total_Profit,
    ROUND(AVG(`Profit Margin %`),2) AS Avg_Margin
FROM superstore_cleaned
GROUP BY Region
ORDER BY Total_Profit DESC;



-- Top 10 Customers by Revenue

SELECT 
    `Customer Name`,
    COUNT(DISTINCT `Order ID`) AS Total_Orders,
    ROUND(SUM(Sales), 2)       AS Total_Revenue,
    ROUND(SUM(Profit), 2)      AS Total_Profit
FROM superstore_cleaned
GROUP BY `Customer Name`
ORDER BY Total_Revenue DESC
LIMIT 10;



-- Loss Making Sub-Categories

SELECT 
    `Sub-Category`,
    ROUND(SUM(Profit), 2) AS Total_Loss,
    COUNT(*)              AS Loss_Orders
FROM superstore_cleaned
WHERE Profit < 0
GROUP BY `Sub-Category`
ORDER BY Total_Loss ASC
LIMIT 5;





-- Monthly Revenue Trend

SELECT 
    `Order Year`,
    `Order Month`,
    ROUND(SUM(Sales), 2) AS Monthly_Revenue,
    ROUND(SUM(Profit), 2) AS Monthly_Profit
FROM superstore_cleaned
GROUP BY `Order Year`, `Order Month`
ORDER BY `Order Year`, `Order Month`;




-- Shipping Analysis

SELECT 
    `Ship Mode`,
    COUNT(*)                      AS Total_Orders,
    ROUND(SUM(Sales), 2)          AS Total_Sales,
    ROUND(AVG(`Days to Ship`), 1) AS Avg_Days_to_Ship
FROM superstore_cleaned 
GROUP BY `Ship Mode`
ORDER BY Total_Sales DESC;



-- Top 5 States by Revenue

SELECT 
    State,
    ROUND(SUM(Sales), 2)  AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    COUNT(*)              AS Total_Orders
FROM superstore_cleaned 
GROUP BY State
ORDER BY Total_Sales DESC
LIMIT 5;



-- Year over Year Growth (Window Function)
	
SELECT 
    `Order Year`,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(
        SUM(Sales) - LAG(SUM(Sales)) 
        OVER (ORDER BY `Order Year`), 2
    ) AS YoY_Growth
FROM superstore_cleaned
GROUP BY `Order Year`
ORDER BY `Order Year`;

