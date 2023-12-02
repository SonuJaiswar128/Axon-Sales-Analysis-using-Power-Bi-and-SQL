USE classicmodels;

-- Avgerage delivery days by cities

SELECT country,AVG(datediff(shippeddate,orderdate)) AS Average_Delivery_Days FROM customers
 INNER JOIN orders ON
customers.customernumber = orders.customernumber 
INNER JOIN orderdetails ON orders.ordernumber=orderdetails.ordernumber 
GROUP BY country ORDER BY Average_Delivery_Days DESC;
----------------------------------------------------------------------------------------------------------------------------------------------------
-- Average sales by customer

SELECT Customername,AVG(quantityordered*priceeach)AS Average_Sales FROM customers
 INNER JOIN orders ON orders.customernumber=customers.customernumber 
INNER JOIN orderdetails ON orders.ordernumber = orderdetails.ordernumber
 GROUP BY Customername ORDER BY Average_Sales DESC;
----------------------------------------------------------------------------------------------------------------------------------------------------
-- Best Selling Products.

SELECT productname,SUM(quantityordered)AS Total_Quantity_Sold FROM orderdetails
INNER JOIN products ON orderdetails.productcode=products.productcode 
GROUP BY productname
ORDER BY Total_Quantity_Sold DESC;
----------------------------------------------------------------------------------------------------------------------------------------------------
-- Customer Segment

SELECT customername,count(Orders.ordernumber) AS Total_Orders,
CASE 
WHEN count(Orders.Ordernumber)>5 THEN 'Loyal Customer'
WHEN count(Orders.Ordernumber)>2 THEN 'Ocassional Customer'
ELSE 'One-Time Customer'
END AS Customer_Segment
FROM customers INNER JOIN orders ON customers.customernumber = orders.customernumber INNER JOIN
orderdetails ON orderdetails.ordernumber = orders.ordernumber GROUP BY customername ORDER BY Customer_Segment;
----------------------------------------------------------------------------------------------------------------------------------------------------
-- Customer life time value

SELECT Customername,SUM(quantityordered*priceeach)AS Total_Sales, count(DISTINCT orderdate) AS Total_Orders 
FROM orderdetails INNER JOIN orders ON orders.ordernumber = orderdetails.ordernumber
INNER JOIN customers ON customers.customernumber = orders.customernumber 
GROUP BY Customername ORDER BY  Total_Sales DESC;
----------------------------------------------------------------------------------------------------------------------------------------------------
-- Product Profitability
SELECT
    productname,
        SUM(quantityordered * priceeach) - SUM(quantityordered * buyprice) AS Total_Profit
FROM
    products
INNER JOIN
    orderdetails
ON
    products.productcode = orderdetails.productcode
GROUP BY
    productname
ORDER BY
    Total_Profit DESC;
----------------------------------------------------------------------------------------------------------------------------------------------------
 -- Sales Emploee Performance
 
SELECT concat(Firstname,' ',lastname) AS Sales_Employee_Name,SUM(quantityOrdered*priceeach) AS Total_Sales FROM
employees INNER JOIN customers ON employees.employeenumber = customers.SalesRepEmployeeNumber
INNER JOIN orders ON orders.customernumber = customers.customernumber
INNER JOIN Orderdetails ON orders.ordernumber = orderdetails.ordernumber
 GROUP BY Sales_Employee_Name ORDER BY Total_Sales DESC;
 ----------------------------------------------------------------------------------------------------------------------------------------------------
-- Seasonal Sales pattern

SELECT date_format(orderdate,'%Y-%m')AS Month_Year ,SUM(quantityordered * priceeach) AS Total_Revenue
FROM orders INNER JOIN orderdetails ON orders.ordernumber = orderdetails.ordernumber GROUP BY month_year ORDER BY month_year ;
----------------------------------------------------------------------------------------------------------------------------------------------------
-- Suplier performance by delivery times

SELECT productvendor,AVG(datediff(requireddate,orderdate)) AS Average_Delivery_Time FROM products
INNER JOIN orderdetails ON products.productcode=orderdetails.productcode 
INNER JOIN orders ON orderdetails.ordernumber=orders.ordernumber 
GROUP BY productvendor ORDER BY Average_Delivery_Time DESC;
----------------------------------------------------------------------------------------------------------------------------------------------------
-- Seasonal Sales pattern

SELECT date_format(orderdate,'%Y-%m')AS Month_Year ,SUM(quantityordered * priceeach) AS Total_Revenue
FROM orders INNER JOIN orderdetails ON orders.ordernumber = orderdetails.ordernumber GROUP BY month_year ORDER BY month_year ;
----------------------------------------------------------------------------------------------------------------------------------------------------
-- Sales by product Line.

SELECT productline,SUM(quantityordered * priceeach) AS Total_Revenue FROM products
INNER JOIN orderdetails ON products.productcode =orderdetails.productcode
GROUP BY productline ORDER BY Total_Revenue DESC;
----------------------------------------------------------------------------------------------------------------------------------------------------
-- Total Sales by Countries

SELECT country,SUM(quantityordered*priceeach) AS Total_Sales FROM customers
 INNER JOIN orders ON customers.customernumber = orders.customernumber 
INNER JOIN orderdetails ON orders.ordernumber=orderdetails.ordernumber 
GROUP BY country ORDER BY Total_Sales DESC;
----------------------------------------------------------------------------------------------------------------------------------------------------






