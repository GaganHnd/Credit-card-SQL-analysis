-- Insert Customers
INSERT INTO Customers VALUES
(1, 'Rahul', 24, 'Bangalore', 720),
(2, 'Priya', 27, 'Mumbai', 640),
(3, 'Arjun', 22, 'Delhi', 590);

-- Insert Transactions
INSERT INTO Transactions VALUES
(101, 1, '2025-09-01', 5000, 'Electronics', 'Bangalore'),
(102, 1, '2025-09-02', 100, 'Food', 'Chennai'),
(103, 2, '2025-09-02', 20000, 'Travel', 'Dubai'),
(104, 3, '2025-09-03', 300, 'Food', 'Delhi'),
(105, 3, '2025-09-03', 300, 'Food', 'Delhi'); -- duplicate suspicious txn

-- Insert Payments
INSERT INTO Payments VALUES
(201, 1, '2025-08-31', '2025-08-30', 5000, 5000),
(202, 2, '2025-08-31', '2025-09-05', 7000, 4000), -- late + partial
(203, 3, '2025-08-31', '2025-09-01', 6000, 6000);
