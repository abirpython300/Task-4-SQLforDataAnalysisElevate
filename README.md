# Task-4-SQLforDataAnalysisElevate
Use SQL queries to extract and analyze data from a database
Northwind SQL Practice Project

This project uses the Northwind sample database to practice and demonstrate essential SQL concepts for data analysis and query optimization. The database contains tables for Orders, Customers, Employees, Products, Suppliers, Categories, and OrderDetails, making it an ideal playground for simulating an e-commerce system.

📂 Project Overview

The project covers a wide range of SQL skills including:

Basic Queries: SELECT, WHERE, ORDER BY, LIMIT

Aggregation: GROUP BY, SUM(), AVG(), COUNT()

Joins: INNER JOIN, LEFT JOIN, RIGHT JOIN

Subqueries: Nested queries for filtering and comparisons

Views: Creating reusable summaries for business analysis

Indexes: Performance tuning with single-column and composite indexes

🗂 SQL Exercises
1. Basic SELECT, WHERE, ORDER BY

List all products with price and stock.

Show all customers from Germany.

Retrieve the top 10 most expensive products.

2. GROUP BY + Aggregates

Total number of customers per country.

Average freight per shipper/country.

Orders handled by each employee.

3. Joins

Orders with customer and employee details.

Products with their suppliers.

Customers with or without orders.

Products that were never ordered.

4. Subqueries

Customers with more orders than the average.

Employee(s) with the highest sales.

Top 5 customers by total order value.

5. Views

CustomerOrderSummary: Customer, Total Orders, Total Order Value.

TopProductsBySales: Product, Category, Quantity Sold, Total Revenue.

EmployeePerformance: Employee, Number of Orders, Total Sales.

6. Index Optimization

Index on Orders.OrderDate for faster filtering by date range.

Composite index on OrderDetails(ProductID, OrderID) for faster joins.

Recreate index on Customers.Country to optimize country filters.

🛠️ How to Use

Setup Database

Download and install the Northwind database for your SQL engine (MySQL / PostgreSQL / SQL Server).

Links:

MySQL Northwind dump

PostgreSQL Northwind

SQL Server Northwind

Run Queries

Open your SQL client (MySQL Workbench, pgAdmin, SSMS, etc.)

Copy and run the queries from this project folder.

Test Index Performance

Use EXPLAIN or EXPLAIN ANALYZE to compare query execution before and after creating indexes.

📊 Key Learnings

Writing efficient queries with filtering, sorting, and grouping.

Using joins to combine multiple tables into meaningful insights.

Creating views for reusable business reports.

Applying indexing strategies to improve performance.

🚀 Future Enhancements

Add stored procedures for automated reporting.

Build a Power BI / Tableau dashboard on top of queries.

Convert queries into a Python/SQLAlchemy project for dynamic analysis.

#1.Basic SELECT, WHERE, ORDER BY
#List all products with their names, unit price, and units in stock.
 <img width="603" height="395" alt="image" src="https://github.com/user-attachments/assets/d1bd177f-8405-4c7d-9158-e3128ff03b2c" />

#Show all customers from Germany, ordered by CompanyName.
<img width="513" height="327" alt="image" src="https://github.com/user-attachments/assets/505f2da4-df34-44c7-9a6d-83dcb88068b8" />

 
#Retrieve the top 10 most expensive products (ProductName, UnitPrice), ordered by UnitPrice descending.
<img width="355" height="388" alt="image" src="https://github.com/user-attachments/assets/80902c64-2ba3-4bbb-bafe-045c756f9262" />

#2. GROUP BY + Aggregates
#Find the total number of customers per country.
 <img width="347" height="392" alt="image" src="https://github.com/user-attachments/assets/ae718a3e-82b0-439c-8f6a-fa2809f2b786" />

#Show the average freight (AVG(Freight)) per ship country.
 <img width="397" height="273" alt="image" src="https://github.com/user-attachments/assets/87a8030b-ba5e-456a-a34e-6d6a6b66f2b1" />

#For each employee, calculate the total number of orders they handled.
 <img width="323" height="277" alt="image" src="https://github.com/user-attachments/assets/74ad1e87-ff9d-4f43-9446-dfeef5da5385" />

#3. JOINS
#List all orders with the customer’s company name and the employee’s full name. (INNER JOIN Orders, Customers, Employees)
 <img width="636" height="331" alt="image" src="https://github.com/user-attachments/assets/2be3b504-aad3-4026-a815-1fe588bae541" />

#Show all products and their category names (INNER JOIN Products, categories).
 <img width="531" height="333" alt="image" src="https://github.com/user-attachments/assets/bec86bd3-ca7c-4e22-b4b7-66c3ee6ec2de" />

#List all customers and their orders (LEFT JOIN to include customers with no orders).
 <img width="309" height="334" alt="image" src="https://github.com/user-attachments/assets/a71b8d3d-6b11-4d6c-a934-33e3eafbdab2" />

#Find products that have never been ordered (RIGHT JOIN / LEFT JOIN + IS NULL).
 <img width="341" height="333" alt="image" src="https://github.com/user-attachments/assets/46ad4663-5055-4400-a881-ee319514b325" />

#Find all products that are more expensive than the average product price.
 <img width="503" height="323" alt="image" src="https://github.com/user-attachments/assets/af37b8c7-7e28-4be3-b642-13dcbcc26f00" />

#List customers who have placed more orders than the average number of orders per customer.
 <img width="498" height="336" alt="image" src="https://github.com/user-attachments/assets/8ca37b87-bdf6-40b8-99dc-0cf0272cfcbb" />

#Retrieve the employee(s) with the highest total sales amount (use OrderDetails.UnitPrice * Quantity).
<img width="563" height="61" alt="image" src="https://github.com/user-attachments/assets/e6f165da-11df-48ba-9eb7-cc8c242ec943" />

#5. Aggregates with Joins
#Calculate the total sales per category (join Products, Categories, and OrderDetails).
 <img width="477" height="273" alt="image" src="https://github.com/user-attachments/assets/a72441d3-9847-44c5-b626-f88e0e60679d" />

#Find the top 5 customers by total order value.
 <img width="305" height="189" alt="image" src="https://github.com/user-attachments/assets/88d0b754-ac08-4735-8a8e-cce9c89a7fd6" />

#For each year, compute the total number of orders and the total sales amount.
 <img width="453" height="127" alt="image" src="https://github.com/user-attachments/assets/f04c9e49-a79e-4d05-8bd7-1b94c29b5eff" />

#6. Views
#Create a view CustomerOrderSummary showing: CustomerID, CompanyName, TotalOrders, TotalOrderValue.
 <img width="694" height="325" alt="image" src="https://github.com/user-attachments/assets/ad75bea0-9f9f-4e8f-8980-cc7b1cb5428d" />

#Create a view TopProductsBySales showing: ProductName, CategoryName, TotalQuantitySold, TotalRevenue.
 <img width="706" height="305" alt="image" src="https://github.com/user-attachments/assets/005e4f32-96d2-4951-a0a0-8e9df077f6ae" />

#Create a view EmployeePerformance with EmployeeName, NumberOfOrders, TotalSales.
 <img width="548" height="283" alt="image" src="https://github.com/user-attachments/assets/ab1895ff-e0b5-4d60-95f0-81ad1194018e" />



