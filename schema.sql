-- Create Customers Table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    city VARCHAR(100),
    credit_score INT
);

-- Create Transactions Table
CREATE TABLE Transactions (
    txn_id INT PRIMARY KEY,
    customer_id INT,
    txn_date DATE,
    amount DECIMAL(10,2),
    category VARCHAR(50),
    location VARCHAR(100),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Create Payments Table
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY,
    customer_id INT,
    due_date DATE,
    payment_date DATE,
    amount_due DECIMAL(10,2),
    amount_paid DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
