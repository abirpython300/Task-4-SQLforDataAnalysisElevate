CREATE database Northwind;
use Northwind;
#1.Basic SELECT, WHERE, ORDER BY
#List all products with their names, unit price, and units in stock.
select productName, unitPrice, QuantityPerUnit
from products;
#Show all customers from Germany, ordered by CompanyName.
select customerID, companyName, country 
from customers
where country = 'Germany'
order by companyName asc
limit 10;
#Retrieve the top 10 most expensive products (ProductName, UnitPrice), ordered by UnitPrice descending.
select productName, unitprice
from products
order by unitPrice desc;

#2. GROUP BY + Aggregates
#Find the total number of customers per country.
select country, count(customerID) AS No_of_customers
FROM CUSTOMERS
group by COUNTRY;
#Show the average freight (AVG(Freight)) per ship country.
select Orderid, Avg(freight) as Average_Freight
from orders
group by orderid;
#with cte and join
WITH FreightByCountry AS (
    SELECT c.Country AS CustomerCountry,
           o.Freight
    FROM Orders o
    JOIN Customers c ON o.CustomerID = c.CustomerID
)
SELECT CustomerCountry, 
       AVG(Freight) AS AvgFreight
FROM FreightByCountry
GROUP BY CustomerCountry
ORDER BY AvgFreight DESC;
;

#For each employee, calculate the total number of orders they handled.
select employeeID, count(orderID) as no_of_orders
from orders
group by employeeID;

#3. JOINS
#List all orders with the customer’s company name and the employee’s full name. (INNER JOIN Orders, Customers, Employees)
with orderhandler as (select o.customerid, e.employeename
from orders as o join employees as e on o.employeeID = e.employeeID)
select oh.customerid, oh.employeename, c.companyname
from orderhandler as oh join customers as c on oh.customerid = c.customerid;
#only joining
SELECT o.OrderID,
       c.CompanyName AS CustomerName,
       e.EmployeeName,
       o.OrderDate
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
INNER JOIN Employees e ON o.EmployeeID = e.EmployeeID
ORDER BY o.OrderID;

#Show all products and their category names (INNER JOIN Products, categories).
select p.productid, p.productname, c.categoryname
from products as p join categories as c on P.categoryID = c.CATEGORYID;
 
#List all customers and their orders (LEFT JOIN to include customers with no orders).
select c.customerid, o.orderid
from customers as c left join orders as o on c.customerid = o.orderid;

#Find products that have never been ordered (RIGHT JOIN / LEFT JOIN + IS NULL).
select p.productname, o.orderid
from products as p left join order_details as o on p.productid = o.orderid
where p.productid is not null;
#4. Subqueries
#Find all products that are more expensive than the average product price.
select productid, productname, unitprice
from products
where unitprice > (select avg(unitprice) as average_price
from products);

#List customers who have placed more orders than the average number of orders per customer.
SELECT c.CustomerID,
       c.CompanyName,
       COUNT(o.OrderID) AS TotalOrders
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.CompanyName
HAVING COUNT(o.OrderID) >
       (
           SELECT AVG(OrderCount)
           FROM (
               SELECT COUNT(OrderID) AS OrderCount
               FROM Orders
               GROUP BY CustomerID
           ) AS Subquery
       )
ORDER BY TotalOrders DESC;
#Retrieve the employee(s) with the highest total sales amount (use OrderDetails.UnitPrice * Quantity).
SELECT e.EmployeeID,
        e.EmployeeName,
       SUM(od.UnitPrice * od.Quantity) AS TotalSales
FROM Employees e
JOIN Orders o ON e.EmployeeID = o.EmployeeID
JOIN Order_Details od ON o.OrderID = od.OrderID
GROUP BY e.EmployeeID,e.employeename
HAVING SUM(od.UnitPrice * od.Quantity) =
       (
           SELECT MAX(EmployeeSales)
           FROM (
               SELECT SUM(od.UnitPrice * od.Quantity) AS EmployeeSales
               FROM Employees e
               JOIN Orders o ON e.EmployeeID = o.EmployeeID
               JOIN Order_Details od ON o.OrderID = od.OrderID
               GROUP BY e.EmployeeID
           ) AS Subquery
       );
#5. Aggregates with Joins
#Calculate the total sales per category (join Products, Categories, and OrderDetails).
SELECT c.CategoryID,
       c.CategoryName,
       SUM(od.UnitPrice * od.Quantity) AS TotalSales
FROM Categories c
JOIN Products p ON c.CategoryID = p.CategoryID
JOIN Order_Details od ON p.ProductID = od.ProductID
GROUP BY c.CategoryID, c.CategoryName
ORDER BY TotalSales DESC;
#Find the top 5 customers by total order value.
SELECT c.CustomerID,
       SUM(od.UnitPrice * od.Quantity) AS TotalOrderValue
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN Order_Details od ON o.OrderID = od.OrderID
GROUP BY c.CustomerID, c.CompanyName
ORDER BY TotalOrderValue DESC
LIMIT 5;
#For each year, compute the total number of orders and the total sales amount.
SELECT YEAR(o.OrderDate) AS OrderYear,
       COUNT(DISTINCT o.OrderID) AS TotalOrders,
       SUM(od.UnitPrice * od.Quantity) AS TotalSales
FROM Orders o
JOIN Order_Details od ON o.OrderID = od.OrderID
GROUP BY YEAR(o.OrderDate)
ORDER BY OrderYear;
#6. Views
#Create a view CustomerOrderSummary showing: CustomerID, CompanyName, TotalOrders, TotalOrderValue.
#without view
select c.customerid, c.companyname, count(o.orderid) as totalorders, sum(od.unitprice*od.quantity) as totalordervalue
from orders o join
customers c on o.customerid=c.customerid
join order_details od on od.orderid=od.orderid
group by c.customerid, c.companyname;
#with view
CREATE VIEW CustomerOrderSummary AS
SELECT c.CustomerID,
       c.CompanyName,
       COUNT(DISTINCT o.OrderID) AS TotalOrders,
       SUM(od.UnitPrice * od.Quantity) AS TotalOrderValue
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
LEFT JOIN Order_Details od ON o.OrderID = od.OrderID
GROUP BY c.CustomerID, c.CompanyName;
SELECT * FROM CustomerOrderSummary ORDER BY TotalOrderValue DESC;
#Create a view TopProductsBySales showing: ProductName, CategoryName, TotalQuantitySold, TotalRevenue.
CREATE VIEW TopProductsBySales AS
SELECT p.ProductName,
       c.CategoryName,
       SUM(od.Quantity) AS TotalQuantitySold,
       SUM(od.UnitPrice * od.Quantity) AS TotalRevenue
FROM Products p
JOIN Categories c ON p.CategoryID = c.CategoryID
JOIN Order_Details od ON p.ProductID = od.ProductID
GROUP BY p.ProductName, c.CategoryName;

SELECT *
FROM TopProductsBySales
ORDER BY TotalRevenue DESC
LIMIT 10;
#Create a view EmployeePerformance with EmployeeName, NumberOfOrders, TotalSales.
CREATE VIEW EmployeePerformance2 AS
SELECT e.Employeename,
       COUNT(DISTINCT o.OrderID) AS NumberOfOrders,
       SUM(od.UnitPrice * od.Quantity) AS TotalSales
FROM Employees e
LEFT JOIN Orders o ON e.EmployeeID = o.EmployeeID
LEFT JOIN Order_Details od ON o.OrderID = od.OrderID
GROUP BY e.Employeename;

SELECT *
FROM EmployeePerformance2;

#7. Indexing & Optimization
#Create an index on Orders.OrderDate and test query performance when filtering by a date range.
ALTER TABLE Orders
MODIFY OrderDate DATE;
CREATE INDEX idx_orders_orderdate
ON Orders(OrderDate);
#Create a composite index on OrderDetails(ProductID, OrderID) and check query speed for joins.
CREATE INDEX idx_order_details_product_order
ON Order_Details(ProductID, OrderID);

