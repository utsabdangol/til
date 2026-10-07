-- Subqueries

-- Subqueries are basically queries within queries.


SELECT *
FROM employee_demographics;


-- We can use a subquery to find employees who work in the Parks and Rec Department.
-- Instead of using a JOIN, we can use the subquery inside the WHERE statement.

SELECT *
FROM employee_demographics
WHERE employee_id IN 
			(SELECT employee_id
				FROM employee_salary
                WHERE dept_id = 1);


-- The subquery basically gives us a list of employee_ids
-- which the outer query then uses.


-- The subquery can only return 1 column when we use it like this.

SELECT *
FROM employee_demographics
WHERE employee_id IN 
			(SELECT employee_id, salary
				FROM employee_salary
                WHERE dept_id = 1);

-- This gives an error because the subquery is returning more than 1 column.


-- We can also use subqueries in the SELECT and FROM statements.


-- Let's say we want to compare each salary to the average salary.

SELECT first_name, salary, AVG(salary)
FROM employee_salary;

-- This doesn't work because we are using regular columns with an aggregate function.
-- We could use GROUP BY, but then we get the average for each group.

SELECT first_name, salary, AVG(salary)
FROM employee_salary
GROUP BY first_name, salary;

-- This gives us the average PER GROUP, which isn't what we want.


-- A subquery is useful here because we can get the overall average salary.

SELECT first_name, 
salary, 
(SELECT AVG(salary) 
	FROM employee_salary)
FROM employee_salary;


-- We can also use a subquery in the FROM statement.
-- Here it is almost like we are creating a small table to query from.

SELECT *
FROM (SELECT gender, MIN(age), MAX(age), COUNT(age), AVG(age)
FROM employee_demographics
GROUP BY gender);


-- This doesn't work because we need to give the subquery a name.


SELECT gender, AVG(Min_age)
FROM (SELECT gender, MIN(age) Min_age, MAX(age) Max_age, COUNT(age) Count_age, AVG(age) Avg_age
FROM employee_demographics
GROUP BY gender) AS Agg_Table
GROUP BY gender;