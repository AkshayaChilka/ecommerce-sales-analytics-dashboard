CREATE DATABASE ecommerce;
USE ecommerce;
#1. Total Revenue + Total Orders + Avg Order Value
SELECT 
    SUM(Amount) AS Total_Revenue,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    ROUND(SUM(Amount) / COUNT(DISTINCT Order_ID), 2) AS Avg_Order_Value
FROM ecommerce;

#2. Revenue Growth by Category Over Time
SELECT 
    DATE_FORMAT(Date, '%Y-%m') AS Month,
    Category,
    SUM(Amount) AS Revenue
FROM ecommerce
GROUP BY Month, Category
ORDER BY Month;

#3. Top 5 Cities Contributing % to Total Revenue
SELECT 
    ship_city,
    SUM(Amount) AS Revenue,
    ROUND(SUM(Amount) * 100 / (SELECT SUM(Amount) FROM ecommerce), 2) AS Contribution_Percentage
FROM ecommerce
GROUP BY ship_city
ORDER BY Revenue DESC
LIMIT 5;

#4. Category Performance with Ranking
SELECT 
    Category,
    SUM(Amount) AS Revenue,
    RANK() OVER (ORDER BY SUM(Amount) DESC) AS Rank_Position
FROM ecommerce
GROUP BY Category;

#5. Delivery Success Rate
SELECT 
    courier_status,
    COUNT(*) AS Orders,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM ecommerce), 2) AS Percentage
FROM ecommerce
GROUP BY courier_status;

#6. High Value Orders
SELECT *
FROM ecommerce
WHERE Amount > (
    SELECT AVG(Amount) + 2 * STDDEV(Amount) FROM ecommerce
);

#7. Repeat vs One-time Customers
SELECT 
    Order_ID,
    COUNT(*) AS Order_Count
FROM ecommerce
GROUP BY Order_ID
HAVING COUNT(*) > 1;

#8. City-wise Average Order Value
SELECT 
    ship_city,
    ROUND(SUM(Amount) / COUNT(DISTINCT Order_ID), 2) AS Avg_Order_Value
FROM ecommerce
GROUP BY ship_city
ORDER BY Avg_Order_Value DESC;

#9. Contribution of Each Category in %
SELECT 
    Category,
    ROUND(SUM(Amount) * 100 / (SELECT SUM(Amount) FROM ecommerce), 2) AS Contribution
FROM ecommerce
GROUP BY Category
ORDER BY Contribution DESC;

#10. Daily Revenue Trend with Moving Average
SELECT 
    Date,
    SUM(Amount) AS Daily_Revenue,
    ROUND(AVG(SUM(Amount)) OVER (ORDER BY Date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 2) AS Moving_Avg_7Days
FROM ecommerce
GROUP BY Date;

#11. Top Performing Fulfillment Method
SELECT 
    fulfilled_by,
    SUM(Amount) AS Revenue,
    COUNT(*) AS Orders
FROM ecommerce
GROUP BY fulfilled_by
ORDER BY Revenue DESC;

#12. Cancellation Rate
SELECT 
    ROUND(
        SUM(CASE WHEN courier_status = 'Cancelled' THEN 1 ELSE 0 END) * 100.0 
        / COUNT(*), 2
    ) AS Cancellation_Rate
FROM ecommerce;

#13. Product Size Demand Analysis
SELECT 
    Size,
    COUNT(*) AS Orders
FROM ecommerce
GROUP BY Size
ORDER BY Orders DESC;ecommerceordersorders