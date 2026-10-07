-- Case Statements

-- A Case Statement allows to add logic to my Select Statement,
-- sort of like an if else statement in other programming languages.

SELECT * 
FROM employee_demographics;


SELECT first_name, 
last_name, 
CASE
	WHEN age <= 30 THEN 'Young'
END
FROM employee_demographics;


-- it can add multiple conditions using WHEN.

SELECT first_name, 
last_name, 
CASE
	WHEN age <= 30 THEN 'Young'
    WHEN age BETWEEN 31 AND 50 THEN 'Old'
    WHEN age >= 50 THEN "On Death's Door"
END
FROM employee_demographics;

-- Poor Jerry


-- Case Statements to perform calculations.

-- Let's look at giving bonuses to employees

SELECT * 
FROM employee_salary;


-- Pawnee Council sent out a memo about their bonus and pay increase structure.
-- If they make less than 45k then they get a 5% raise.
-- If they make more than 45k they get a 7% raise.

SELECT first_name, last_name, salary,
CASE
	WHEN salary > 45000 THEN salary + (salary * 0.05)
    WHEN salary < 45000 THEN salary + (salary * 0.07)
END AS new_salary
FROM employee_salary;


-- Unfortunately Jerry was not included in the pay increases.
-- Maybe Next Year.


-- Now we also need to account for the bonuses, so let's make a new column.

SELECT first_name, last_name, salary,
CASE
	WHEN salary > 45000 THEN salary + (salary * 0.05)
    WHEN salary < 45000 THEN salary + (salary * 0.07)
END AS new_salary,
CASE
	WHEN dept_id = 6 THEN salary * .10
END AS Bonus
FROM employee_salary;

-- Ben is the only one who gets a bonus