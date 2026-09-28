--joins 

select *
from employees_demographics;

select *
from employee_salary;

--inner join
-- if you write join without specifying the type of join, it will default to an inner join.
select *
from employee_demographics
inner join employee_salary
on employee_demographics.employee_id = employee_salary.employee_id;
