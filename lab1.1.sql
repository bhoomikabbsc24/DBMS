CREATE DATABASE OnlineShoppingDB;
USE OnlineShoppingDB;
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15)
);
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    StockQuantity INT
);
CREATE TABLE Stores (
    StoreID INT PRIMARY KEY,
    StoreName VARCHAR(100),
    Location VARCHAR(100)
);
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT NOT NULL,
    StoreID INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) ON DELETE CASCADE,
    FOREIGN KEY (StoreID) REFERENCES Stores(StoreID)
);
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY,
    OrderID INT,
    Amount DECIMAL(10,2),
    PaymentDate DATE,
    PaymentMethod VARCHAR(50),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);
INSERT INTO Customers VALUES
(1, 'Alice Johnson', 'alice@example.com', '9876543210'),
(2, 'Bob Smith', 'bob@example.com', '8765432109'),
(3, 'Charlie Brown', 'charlie@example.com', '7654321098'),
(4, 'Diana White', 'diana@example.com', '6543210987'),
(5, 'Ethan Lee', 'ethan@example.com', '5432109876');
INSERT INTO Products VALUES
(1, 'Laptop', 'Electronics', 55000, 20),
(2, 'Sofa', 'Furniture', 15000, 10),
(3, 'Chair', 'Furniture', 3000, 50),
(4, 'Smartphone', 'Electronics', 25000, 30),
(5, 'Table', 'Furniture', 7000, 15);
INSERT INTO Stores VALUES
(1, 'Tech World', 'Bangalore'),
(2, 'Home Comforts', 'Mumbai'),
(3, 'Style Hub', 'Delhi'),
(4, 'FurniMart', 'Chennai'),
(5, 'ElectroShop', 'Hyderabad');
INSERT INTO Orders VALUES
(1, 1, 1, '2025-08-01'),
(2, 2, 2, '2025-08-02'),
(3, 3, 3, '2025-08-03'),
(4, 4, 4, '2025-08-04'),
(5, 5, 5, '2025-08-05');
INSERT INTO OrderDetails VALUES
(1, 1, 1, 1), -- Alice buys Laptop
(2, 2, 2, 1), -- Bob buys Sofa
(3, 3, 4, 2), -- Charlie buys 2 Smartphones
(4, 4, 3, 4), -- Diana buys 4 Chairs
(5, 5, 5, 1); -- Ethan buys Table
INSERT INTO Payments VALUES
(1, 1, 55000, '2025-08-01', 'Credit Card'),
(2, 2, 15000, '2025-08-02', 'UPI'),
(3, 3, 50000, '2025-08-03', 'Net Banking'),
(4, 4, 12000, '2025-08-04', 'Cash'),
(5, 5, 7000, '2025-08-05', 'Credit Card');
UPDATE Products
SET StockQuantity = StockQuantity - 4
WHERE ProductID = 3;
UPDATE Products
SET Price = Price * 1.10
WHERE Category = 'Furniture' AND ProductID > 0;
SELECT * FROM Customers;
SELECT * FROM Products;
SELECT * FROM Stores;
SELECT * FROM Orders;
SELECT * FROM OrderDetails;
SELECT * FROM Payments;

















