USE employees;

-- Question 1
select * from employees;
select * from salaries;

-- Question 2
select salary from salaries where salary*1.7 > 100000;

-- Question 3
select AVG(salary) from salaries where emp_no > 1510;

-- Question 4
select emp_no, AVG(salary) from salaries group by emp_no;

-- Question 5
select employees.first_name, employees.last_name, salaries.salary from employees inner join salaries on employees.emp_no = salaries.emp_no;

-- Question 6
DELIMITER $$
CREATE PROCEDURE emp_avg_salary(IN p_emp_no INT)
BEGIN
	SELECT AVG(salary) from salaries where salaries.emp_no = p_emp_no;
END $$
DELIMITER ;

call emp_avg_salary(11300);
