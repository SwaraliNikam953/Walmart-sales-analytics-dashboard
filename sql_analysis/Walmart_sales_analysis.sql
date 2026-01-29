-- Walmart Sales Analytics SQL Queries
-- Author: Swarali Nikam

-- 1. Total Revenue
SELECT SUM(Weekly_Sales) AS Total_Revenue
FROM walmart_sales;

-- 2. Average Weekly Sales
SELECT AVG(Weekly_Sales) AS Avg_Weekly_Sales
FROM walmart_sales;

-- 3. Total Transactions
SELECT COUNT(*) AS Total_Transactions
FROM walmart_sales;

-- 4. Monthly Revenue Trend
SELECT 
    EXTRACT(YEAR FROM Date) AS Year,
    EXTRACT(MONTH FROM Date) AS Month,
    SUM(Weekly_Sales) AS Monthly_Revenue
FROM walmart_sales
GROUP BY 1,2
ORDER BY 1,2;

-- 5. Top 10 Performing Stores
SELECT 
    Store,
    SUM(Weekly_Sales) AS Total_Revenue
FROM walmart_sales
GROUP BY Store
ORDER BY Total_Revenue DESC
LIMIT 10;

-- 6. Top 10 Performing Departments
SELECT 
    Dept,
    SUM(Weekly_Sales) AS Total_Revenue
FROM walmart_sales
GROUP BY Dept
ORDER BY Total_Revenue DESC
LIMIT 10;

-- 7. Holiday vs Non-Holiday Sales Impact
SELECT 
    IsHoliday,
    SUM(Weekly_Sales) AS Total_Revenue
FROM walmart_sales
GROUP BY IsHoliday;

-- 8. Month-over-Month Growth
WITH monthly_sales AS (
    SELECT 
        DATE_TRUNC('month', Date) AS Month,
        SUM(Weekly_Sales) AS Revenue
    FROM walmart_sales
    GROUP BY 1
)
SELECT 
    Month,
    Revenue,
    LAG(Revenue) OVER (ORDER BY Month) AS Previous_Month_Revenue,
    (Revenue - LAG(Revenue) OVER (ORDER BY Month)) 
        / LAG(Revenue) OVER (ORDER BY Month) * 100 AS MoM_Growth_Percentage
FROM monthly_sales;
