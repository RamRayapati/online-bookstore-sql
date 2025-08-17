
-- SQL Project: Online Bookstore Database

-- 1. Create Database & Tables
CREATE DATABASE OnlineBookstore;
USE OnlineBookstore;

-- Table: Books
CREATE TABLE Books (
    BookID INT PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Price DECIMAL(6,2),
    Stock INT
);

-- Table: Customers
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    Email VARCHAR(100) UNIQUE,
    City VARCHAR(50)
);

-- Table: Orders
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Table: OrderDetails
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    BookID INT,
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);

-- 2. Insert Sample Data

-- Books
INSERT INTO Books (Title, Author, Price, Stock) VALUES
('SQL Basics', 'John Smith', 499.99, 20),
('Advanced SQL', 'Alice Johnson', 899.50, 15),
('Database Design', 'Mark Brown', 699.00, 10);

-- Customers
INSERT INTO Customers (Name, Email, City) VALUES
('Thulasi Ram', 'thulasi@example.com', 'Tirupati'),
('Priya Reddy', 'priya@example.com', 'Hyderabad'),
('Raj Kumar', 'raj@example.com', 'Chennai');

-- Orders
INSERT INTO Orders (CustomerID, OrderDate) VALUES
(1, '2025-08-10'),
(2, '2025-08-11');

-- OrderDetails
INSERT INTO OrderDetails (OrderID, BookID, Quantity) VALUES
(1, 1, 2),
(1, 3, 1),
(2, 2, 1);

-- 3. Example Queries

-- Get all customers who ordered books
SELECT DISTINCT c.Name, c.City
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID;

-- Get total sales by book
SELECT b.Title, SUM(od.Quantity) AS TotalSold
FROM Books b
JOIN OrderDetails od ON b.BookID = od.BookID
GROUP BY b.Title;

-- Get customer order history
SELECT c.Name, b.Title, od.Quantity, o.OrderDate
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Books b ON od.BookID = b.BookID;
