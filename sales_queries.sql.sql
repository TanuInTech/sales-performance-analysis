CREATE DATABASE sales_project;
USE sales_project;
CREATE TABLE sales_data (
    Product_ID INT,
    Sale_Date DATE,
    Sales_Rep VARCHAR(50),
    Region VARCHAR(50),
    Sales_Amount DECIMAL(10, 2),
    Quantity_Sold INT,
    Product_Category VARCHAR(50),
    Unit_Cost DECIMAL(10,2),
    Unit_Price DECIMAL(10,2),
    Customer_Type VARCHAR(50),
    Discount DECIMAL(5,2),
    Payment_Method VARCHAR(50),
    Sales_Channel VARCHAR(50),
    Region_and_Sales_Rep VARCHAR(100)
);   
#TOTAL SALES 
SELECT SUM(Sales_Amount) AS Total_Sales
FROM sales_data;
#TOTAL PROFIT
SELECT
SUM((Unit_Price - Unit_Cost) * Quantity_Sold) AS Total_Profit
FROM sales_data;
#REGION WISE SALES
SELECT Region, SUM(Sales_Amount) AS Total_Sales
FROM sales_data
GROUP BY Region
ORDER BY Total_Sales DESC;
#BEST SALES rep
SELECT Sales_Rep, SUM(Sales_Amount) AS Total_Sales
FROM sales_data
GROUP BY Sales_Rep
ORDER BY Total_Sales DESC;
# MONTHLY SALES TREND
SELECT 
MONTH(Sale_date) AS Month_No,SUM(Sales_Amount) AS Monthly_Sales 
FROM sales_data
GROUP BY MONTH(Sale_Date)
ORDER BY Month_No;
 #PRODUCT CATEGORY PERFORMANCE
 SELECT Product_Category,SUM(Sales_Amount) AS Total_Sales
 FROM sales_data
 GROUP BY Product_Category
 ORDER BY Total_Sales DESC;
 #CUSTOMER TYPE ANALYSIS
 SELECT Customer_Type, COUNT(*) AS Total_Customers, SUM(Sales_Amount) AS Revenue
 FROM sales_data
 GROUP BY Customer_Type;
 #PAYMENT METHOD ANALYSIS
 SELECT Payment_Method, SUM(Sales_Amount) AS Revenue
 FROM sales_data
 GROUP BY Payment_Method
 ORDER BY Revenue DESC;
 #SALES CHANNEL PERFORMANCE
 SELECT Sales_Channel, SUM(Sales_Amount) AS Revenue
 FROM sales_data
 GROUP BY Sales_Channel;
 #TOP 10 HIGHEST SALES TRANSACTIONS
 SELECT *
 FROM sales_data
 ORDER BY Sales_Amount DESC
 LIMIT 10;
 #REGION WISE PROFIT MARGIN
 SELECT 
 Region,
 SUM((Unit_Price - Unit_Cost) * Quantity_Sold) AS Profit
 FROM sales_data
 GROUP BY Region
 ORDER BY Profit DESC;
 #RUNNING TOTAL SALES
 SELECT 
 Sale_Date,
 Sales_Amount,
 SUM(Sales_Amount) OVER(ORDER BY Sale_Date) AS Running_Total
 FROM sales_data;
#RANK SALES REP
SELECT 
Sales_Rep,
SUM(Sales_Amount) AS Total_Sales,RANK() OVER(ORDER BY SUM(Sales_Amount)DESC) AS Ranking
FROM sales_data
GROUP BY Sales_Rep;
#TOP REGION BY PROFIT
SELECT Region, Profit
FROM (
    SELECT
        Region,
        SUM((Unit_Price - Unit_Cost) * Quantity_Sold) AS Profit,
        RANK() OVER(ORDER BY SUM((Unit_Price - Unit_Cost) * Quantity_Sold) DESC) AS rnk
        FROM sales_data
        GROUP BY Region
) t
WHERE rnk = 1;



