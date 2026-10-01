-- UNION is used to combine the **rows** from multiple SELECT queries.
-- Unlike JOIN, which puts columns side-by-side, UNION puts the results
-- from one query on top of the results from another query.

-- The columns being combined should represent the same kind of data.
-- Technically, SQL can combine unrelated data too, but it would not make
-- much sense because the values would be mixed together.

SELECT first_name, last_name
FROM employee_demographics
UNION
SELECT occupation, salary
FROM employee_salary;

-- Here, the first_name/last_name results are placed on top of
-- occupation/salary results.
-- This works because both SELECT statements return 2 columns,
-- but logically the data doesn't make much sense to combine.

-- UNION removes duplicate rows by default.
-- So UNION is basically the same as UNION DISTINCT.

SELECT first_name, last_name
FROM employee_demographics
UNION DISTINCT
SELECT first_name, last_name
FROM employee_salary;

-- UNION ALL keeps everything, including duplicates.

SELECT first_name, last_name
FROM employee_demographics
UNION ALL
SELECT first_name, last_name
FROM employee_salary;

# Actual use case

-- The Parks department wants to find employees who might be relevant
-- for budget cuts.
-------------------

-- I can use multiple queries to find different groups of employees
-- and then combine all of them using UNION.
--------------------------------------------

-- The third column is just a label that tells me WHY the employee
-- was included in the result.

-- Employees older than 50

SELECT first_name, last_name, 'Old'
FROM employee_demographics
WHERE age > 50;

-- Now I can create different categories and combine them.
-- Female employees over 40 are labelled "Old Lady"
-- Male employees over 40 are labelled "Old Man"
-- Employees earning 70,000 or more are labelled "Highly Paid Employee"

SELECT first_name, last_name, 'Old Lady' AS Label
FROM employee_demographics
WHERE age > 40 AND gender = 'Female'

UNION

SELECT first_name, last_name, 'Old Man'
FROM employee_demographics
WHERE age > 40 AND gender = 'Male'

UNION

SELECT first_name, last_name, 'Highly Paid Employee'
FROM employee_salary
WHERE salary >= 70000

ORDER BY first_name;


-- JOIN  = combine columns / put tables side-by-side
-- UNION = combine rows / put query results on top of each other
----------------------------------------------------------------

-- UNION      = removes duplicates
-- UNION ALL  = keeps duplicates
--------------------------------

-- Each SELECT in a UNION needs to return the same number of columns,
-- and the corresponding columns should have compatible data types.
