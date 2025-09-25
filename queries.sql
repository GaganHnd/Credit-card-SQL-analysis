-- 1. High-Value Transactions (Potential Fraud)
SELECT customer_id, txn_id, amount, category, location
FROM Transactions
WHERE amount > 10000;

-- 2. Duplicate Transactions (Suspicious Activity)
SELECT customer_id, amount, category, txn_date, COUNT(*) AS duplicate_count
FROM Transactions
GROUP BY customer_id, amount, category, txn_date
HAVING COUNT(*) > 1;

-- 3. Late Payments (Credit Risk)
SELECT customer_id, due_date, payment_date, amount_due, amount_paid,
       CASE 
         WHEN payment_date > due_date THEN 'Late'
         ELSE 'On-time'
       END AS payment_status
FROM Payments;

-- 4. Customer Spending by Category
SELECT c.name, t.category, SUM(t.amount) AS total_spent
FROM Transactions t
JOIN Customers c ON t.customer_id = c.customer_id
GROUP BY c.name, t.category;

-- 5. Top Customers by Transaction Volume
SELECT c.name, COUNT(t.txn_id) AS txn_count, SUM(t.amount) AS total_spent
FROM Transactions t
JOIN Customers c ON t.customer_id = c.customer_id
GROUP BY c.name
ORDER BY total_spent DESC;

-- 6. Running Total of Spending per Customer
SELECT 
    c.name,
    t.txn_date,
    t.amount,
    SUM(t.amount) OVER (PARTITION BY c.customer_id ORDER BY t.txn_date) AS running_total
FROM Transactions t
JOIN Customers c ON t.customer_id = c.customer_id
ORDER BY c.name, t.txn_date;

-- 7. Rank Customers by Total Spending
SELECT 
    c.name,
    SUM(t.amount) AS total_spent,
    RANK() OVER (ORDER BY SUM(t.amount) DESC) AS spending_rank
FROM Transactions t
JOIN Customers c ON t.customer_id = c.customer_id
GROUP BY c.name;

-- 8. Average Transaction Amount per Customer vs Overall
SELECT 
    c.name,
    AVG(t.amount) AS avg_customer_spent,
    ROUND(AVG(t.amount) OVER (), 2) AS overall_avg_spent
FROM Transactions t
JOIN Customers c ON t.customer_id = c.customer_id
GROUP BY c.name;

-- 9. Detect Customers with Consecutive Late Payments
SELECT 
    p.customer_id,
    c.name,
    p.payment_id,
    p.due_date,
    p.payment_date,
    CASE WHEN p.payment_date > p.due_date THEN 1 ELSE 0 END AS is_late,
    SUM(CASE WHEN p.payment_date > p.due_date THEN 1 ELSE 0 END) 
        OVER (PARTITION BY p.customer_id ORDER BY p.due_date ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) AS late_streak
FROM Payments p
JOIN Customers c ON p.customer_id = c.customer_id
ORDER BY c.name, p.due_date;

-- 10. Spending Trend by Month
SELECT 
    strftime('%Y-%m', txn_date) AS month,
    SUM(amount) AS total_monthly_spent,
    ROUND(AVG(SUM(amount)) OVER (ORDER BY strftime('%Y-%m', txn_date) ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 2) AS moving_avg
FROM Transactions
GROUP BY strftime('%Y-%m', txn_date)
ORDER BY month;
