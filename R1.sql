-- create a database here
CREATE DATABASE onlinebookstore;

-- create table 
CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(100),
    Published_Year INT,
    Price NUMERIC(10,2),
    Stock INT
);

-- Create Customers table
CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);

-- Drop Orders table if it exists
DROP TABLE IF EXISTS Orders;

-- Create Orders table
CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);

SELECT * FROM Books;
SELECT * FROM customers;
SELECT * FROM Orders;

-- Retrieve all books in the fiction genre
SELECT * FROM Books
WHERE Genre='Fiction';

-- Find books published after the year 1950
SELECT * FROM Books
WHERE Published_year>1950

--List all customer from the canada

SELECT * FROM Customers
WHERE country='Canada';

-- order placed in november 
SELECT * FROM Orders
WHERE order_date BETWEEN '2023-11-01' AND  '2023-11-30';

-- Retrieve the total stock of books available
SELECT SUM(Stock)AS Total_Stock
FROM Books;

-- find details of most expensive book
-- we use order by bz we are apply criteria 

SELECT * FROM Books ORDER BY Price  DESC LIMIT 1;

-- show all cust who order more than 1 qty of book
SELECT * FROM Orders
WHERE Quantity>1;  

-- Retrive all order where the total amount exceeds 20$

SELECT * FROM Orders
where total_amount >20;

-- List all geeneres availables in the books table
SELECT DISTINCT genre FROM Books;

-- Find the book with the lowest stock
select * FROM Books order by stock asc;

-- show total revenue from orders
SELECT SUM(total_amount) AS Revenue 
from Orders;

--- ADVANCED QUERY
-- 1) Retrieve the total no. of books sold for each genre:
select * FROM orders;

SELECT b.Genre, SUM(o.Quantity) AS total_book_solds
FROM Orders o                                                     -- b.genre shows book table genre col 
JOIN Books b ON o.book_id = b.book_id
GROUP BY b.Genre ;  

-- 2) Find the avg price of books in the "Fantasy" genre:
SELECT AVG(price) AS avg_price
FROM Books 
WHERE Genre = "Fantasy";  

-- 3) List customers eho have placed at least 2 orders:
SELECT customer_id, COUNT(Order_id) AS ORDER_COUNT
FROM orders
GROUP BY customer_id
HAVING COUNT (Order_id) >=2; 


-- OR 

SELECT c.customer_id, 
       c.Name, 
       COUNT(o.order_id) AS order_count
FROM orders o
JOIN customers c 
    ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.Name
HAVING COUNT(o.order_id) >= 2;

-- Find most frequent ordered book
SELECT Book_id, COUNT(order_id) AS ORDER_COUNT
FROM orders
GROUP BY Book_id
ORDER BY ORDER_COUNT DESC;

-- OR 
SELECT o.Book_id,b.title, COUNT(o.order_id) AS ORDER_COUNT
FROM orders o
JOIN Book_id b ON o.Book_id=b.Book_id
GROUP BY o.book_id,b.title
ORDER BY ORDER_COUNT DESC;

-- 5) top 3 most expensive books of "Fantasy" Genre:
SELECT * FROM books
WHERE Genre="Fantasy"
ORDER BY price DESC limit 3;

-- Retrieve the total qty of book sold by each author
SELECT b.author , SUM(o.quantity) AS Total_Books_Sold
FROM orders o
JOIN books b ON o.book_id=b.book_id
GROUP BY b.Author;

