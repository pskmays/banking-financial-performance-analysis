-- Kenye Mays SQL Queries
/*============================================================================
-- QUESTION 1
-- Database Structure
	-- THE SHOW TABLES command is quick way to see the database structure.
	-- The command shows the name of the tables in the database.
==============================================================================
*/

SHOW TABLES;

/*=====================================================================================================================
-- QUESTION 2
-- Tables’ Structure/Column Information
	-- The DESCRIBE command returns a tables 
    -- field/column name, data type for the column, can the the values in the column be null, and the key constraints
===========================================================================================================================
*/

    DESCRIBE branches;
    DESCRIBE budget_categories;
    DESCRIBE budgets;
    DESCRIBE cost_centers;
    DESCRIBE customers;
    DESCRIBE departments;
    DESCRIBE employees;
    DESCRIBE expenditures;
    DESCRIBE loan_applications;
    DESCRIBE regions;
    DESCRIBE region_states;
    DESCRIBE transactions;
    
/*===============================================================================
-- QUESTION 3
-- How many budget categories are there?
	-- SELECT the category name to count
	-- Only return distinct category names
    -- Used the alias for better readability. 
===================================================================================
*/
    
-- There are twenty-one budget categories
SELECT 
    COUNT(DISTINCT category_name) AS `Number of Budget Categories`
FROM
    budget_categories; 
    
 /*=====================================================================================   
-- QUESTION 4
-- How many cost centers are there?
	-- I used the COUNT() aggregate to find the number of cost centers. 
    -- The DISTINCT keywork handles any duplicate cost_center_codes.
-- There are 43 cost centers
==========================================================================================
*/

SELECT COUNT( DISTINCT cost_center_code) AS `Number of Cost Centers`
	FROM
		cost_centers;

/*================================================================================================
-- QUESTION 5
	-- List all customer transactions over $1,000 and show the 
	-- transaction ID, customer ID, customer Name, amount, transaction date, and merchant category.
=======================================================================================================
*/

SELECT 
    transaction_id AS 'Transaction ID',
    customer_id AS 'Customer ID',
    CONCAT(first_name, ' ', last_name) AS `Customer Name`, -- combine first and last name
    transaction_amount AS 'Transaction Amount', -- 
    DATE(CONCAT_WS('-', year, month, day)) AS 'Transaction Date', -- create date and change it to date format
    merchant_category AS 'Merchant Category'
FROM
    transactions
        INNER JOIN
    customers USING (customer_id) -- link transactions and customers table 
WHERE
    transaction_amount > 1000 -- filter to show rows that have transaction amount greater than > $1000
ORDER BY `Customer Name`, transaction_amount  ASC; -- alphabetical order, then lowest to highest transaction amount

/*=====================================================================================================
-- QUESTION 6 
-- Find the top 10 highest expenditures by amount. Show expense ID, vendor, amount, and fiscal year.
========================================================================================================
*/

SELECT 
    expense_id AS 'Expense ID',
    vendor AS 'Vendor',
    amount AS 'Amount',
    fiscal_year AS 'Fiscal Year'
FROM
    expenditures
ORDER BY amount DESC -- order the results from highest to lowest amount
LIMIT 10; -- only return 10 rows (top 10 vendors)

/*====================================================================================================
-- QUESTION 7 
-- Calculate the total customer transaction amount and transaction count for each merchant category.
========================================================================================================
*/

SELECT 
    merchant_category AS 'Merchant Category',
    SUM(transaction_amount) AS 'Total Transaction Amount', -- add up all the transactions for each merchant category
    COUNT(transaction_amount) AS 'Number of Transactions' -- count the number of transactions for each merchant category
FROM
    transactions
GROUP BY merchant_category -- group all the merchant categories with same name
ORDER BY merchant_category ASC; -- the results will return in alphabeical order

/*==================================================================================================
-- QUESTION 8
	-- Calculate the average expenditure amount per branch and the number of expenses per branch.  
	-- Sort the results from highest to lowest average expenditure.  
	-- Output should include BranchID, BranchName, Number of Expenses, Average Expense Amount.
    ================================================================================================
*/

SELECT 
    location_id AS 'Branch ID',
    city AS 'Branch Name',
    COUNT(expense_id) AS 'Number of Expenses', -- count the number of expenses for each branch
    AVG(amount) AS 'Average Expenditure' -- get the average expenses for each branch
FROM
    branches
        INNER JOIN
    expenditures ON branches.location_id = expenditures.branch_id -- linked the branches and expenditures tables
GROUP BY location_id , city -- group all the location_ids and branch names with same name.
ORDER BY AVG(amount) DESC;
/*=======================================================================================================
-- QUESTION 9 
	-- List Expenditure vendors that have more than 5 expenses and a total spend greater than $25,000. 
	-- Show vendor, number of expenses, and total spending.
=========================================================================================================
*/
SELECT 
    vendor AS 'Vendors',
    COUNT(expense_id) AS `Number of Expenses`, -- count number of expenses 
    SUM(amount) AS `Total Spent` -- add all the total expenses per vendor
FROM
    expenditures
GROUP BY vendor -- group vendors with the same name
HAVING `Number of Expenses` > 5 AND `Total Spent` > 25000
ORDER BY vendor ASC; -- order the results in alphabetical order
/*=========================================================================
-- QUESTION 10 
	-- List all departments whose 2025 total spending exceeds $100,000. 
    -- Output should include:  Department_ID, Fiscal Year, Total spending
============================================================================
*/

SELECT 
    departments.department_id AS 'Department_ID',
    fiscal_year AS 'Fiscal Year',
    SUM(amount) AS `Total Spending` -- add up all of the expenses per department id
FROM
    departments
        INNER JOIN
    expenditures USING (department_id) -- link the departments table and the expenditures table
WHERE fiscal_year = 2025 -- filter rows that have a fiscal year of 2025
GROUP BY departments.department_id, fiscal_year -- group department ids and fiscal year
HAVING `Total Spending` > 100000; -- filter groups that have a total spending greater than $100,000


/*====================================
-- QUESTION 11
-- How many states per region? 
======================================
*/

SELECT 
    region_name AS 'Region',
    COUNT(state_code) AS 'Number of States' -- count the number of states per region
FROM
    regions
        LEFT JOIN -- Some Regions don't have states
    region_states USING (region_id) -- link the regions table to the region_states table
GROUP BY region_name -- group identical region names
ORDER BY region_name ASC; -- order the regions in alphabetical order


/*============================================
-- QUESTION 12 
-- How many branches per region?
===============================================
*/
SELECT 
    region_name AS 'Region',
    COUNT(branches.location_id) AS 'Number of Branches' -- count the number of regions
FROM
    regions
        LEFT JOIN -- I used a left join because I want to see all the regions regardless if they have branches
    branches USING (region_id) -- link the regions and branches table
GROUP BY region_name; -- group regions


/*==========================================================================================================
-- QUESTION 13
-- How many branches are in the same state as their region's hub city? 
==========================================================================================================
*/
SELECT 
	region_name AS 'Region',
    COUNT(*) AS 'Number of Branches in the State as Hub City' -- count the number of branches returned.
FROM
    branches
        INNER JOIN 
    regions USING (region_id) -- connect the branches and regions table
        INNER JOIN
    region_states USING (region_id) -- connect the regions and region_states table
WHERE
    branches.state_code = region_states.state_code -- only return rows if the states match
GROUP BY
	region_name;



/*==========================================================================
-- QUESTION 14
-- What is the total expenditure per department?
============================================================================
*/
SELECT 
    dept_name AS 'Department Name', 
    SUM(amount) AS `Total Expenditure` -- add up the total expenses
FROM
    departments
        LEFT JOIN -- return every department regardless if they have expenses.
    expenditures USING (department_id) -- link tables using the department id
GROUP BY dept_name -- group identical departments
ORDER BY dept_name, `Total Expenditure` DESC; -- sort by alphabetically, then total expenses


/*=========================================================================================
-- QUESTION 15
	-- Top 5 employees with the longest employment and which branch they work at
	-- HINT: Branch number is not an informative piece of information for your audience
	-- There is another “thought” challenge here.  Use your best judgment.
============================================================================================
*/
SELECT 
    full_name AS 'Employee Name',
    city AS 'Branch', -- chose city name as my branch
    hire_date AS  'Hire Date'
FROM
    employees
		INNER JOIN -- I only want employees with a branch 
    branches ON employees.home_office = branches.location_id -- link employees table with branches table using the home_office and location_id field
ORDER BY hire_date ASC -- order hire date from earliest to latest hire_date
LIMIT 5; -- limit results to only 5 rows(TOP 5)

/*=========================================================================================
-- QUESTION 16
	-- How many customers per region? Sort from the highest number to the lowest number.
============================================================================================
*/
SELECT 
    region_name AS 'Region',
    COUNT(customer_id) AS `Number of Customers` -- count the number of customers
FROM
    customers
        INNER JOIN -- only want customers that live in a state
    region_states ON customers.cust_state = region_states.state_code
        INNER JOIN -- only states in a region 
    regions USING (region_id)
GROUP BY region_name -- group identical regions 
ORDER BY `Number of Customers` DESC; -- sort from highest to lowest number of customers
/*====================================================================================================
-- QUESTION 17
	-- Compare the total number of loan applications and the total number of approved applications between applicants 
	-- with good credit history and those with no credit history. 
	-- (This requires you to really understand what the actual data is telling you and what the fields mean.)
 ==================================================================================================================
 */
SELECT 
    CASE
        WHEN credit_history = 1 THEN 'Good Credit History' -- 1 means good credit history
        WHEN credit_history = 0 THEN 'No Credit History' -- 0 means no credit history
        ELSE 'Unknown Credit History' -- error handling for applicants with null credit history
    END AS `Credit History`,
    COUNT(application_id) AS 'Number of Loan Applications', -- count the number of applications
    COUNT(IF(application_status = 'Y',1,NULL)) AS 'Number of Approved Applications' -- count the number of approved applications
FROM
    loan_applications
GROUP BY `Credit History`; -- group credit histories 

-- QUESTION 18
	-- Classify each Customer transaction into a size band using a CASE statement:
	-- Small: < $50
	-- Medium: $50- $499.99
	-- Large: ≥ $500
    
SELECT 
    CONCAT(first_name, ' ', last_name) AS `Customer Name`,
    transaction_amount AS `Transaction Amount`,
    CASE
        WHEN transaction_amount >= 500 THEN 'Large' -- Greater than $500 
        WHEN transaction_amount >= 50 THEN 'Medium' --  $50 <= transaction amount < $500
        WHEN transaction_amount < 50 THEN 'Small' -- Less than $50 
        ELSE 'Unknown Transaction Amount' -- Erorr/NULL handling 
    END AS `Transaction Class`
FROM
    customers
        LEFT JOIN
    transactions USING (customer_id)
ORDER BY `Customer Name` ASC; -- order customers in alphabetical order


/* ************************
  5 ADDITIONAL QUERIES
***************************
 */
 
 /*=============================================
 -- QUERY 1: 
 -- The number of cost centers that are HQS
 ================================================
 */
 
SELECT 
    COUNT(*) AS 'Number of Cost Centers HQs' -- count the number of cost centers HQs
FROM
    cost_centers
WHERE
    cost_center_type = 'HQ'; -- filter HQ cost centers
 /*=======================================================
 -- QUERY 2: 
 -- The customers with more than 1 loan application
 =========================================================
 */
 
SELECT 
    customer_id AS 'Customer ID', COUNT(application_id) AS 'Total Number of Loan Applications' -- count the number applications
FROM
    loan_applications
GROUP BY customer_id -- group identical customer ids
HAVING COUNT(application_id) > 1; -- filter groups of customers

/*================================================
-- QUERY 3: 
-- Who is the branch manager for each branch?
===================================================
*/

SELECT 
    branches.location_id AS 'Branch ID',
    city AS 'Branch',
    branch_manager_employee_id AS 'Branch Manager ID',
    full_name AS 'Branch Manager Name'
FROM
    branches
        LEFT JOIN -- show all branches
    employees ON branches.branch_manager_employee_id = employees.employee_id; -- link branches and employees using the employee ID
 /*=======================================================   
-- QUERY 4: 
-- What customers has history of fraudulent transactions?
===========================================================
*/

SELECT 
    CONCAT(first_name, ' ', last_name) AS `Customer Name`, -- combine first name and last name
    CASE
        WHEN SUM(fraudulent) > 0 THEN 'Fraudulent Transaction History' -- if fraudulent total is greater than zero, the customer has fraudulent transaction history
        ELSE 'No Fraudulent Transaction History'
    END AS 'Fraud Transaction History'
FROM
    customers
        INNER JOIN
    transactions USING (customer_id)
GROUP BY customers.customer_id, `Customer Name` -- group identical customer ids and names
ORDER BY `Customer Name`; -- order alphabetically

/*================================================================
    -- QUERY 5:
    -- Customers who have never made an online transaction
===================================================================
*/
SELECT CONCAT(first_name, ' ', last_name) AS 'Customer Name' -- combine first and last name
FROM customers
WHERE customer_id NOT IN ( -- the customers who's ids are not in the list of online transactions
    SELECT customer_id
    FROM transactions
    WHERE is_online = 1
);





 
 
 
 


    













    







    
        

 

