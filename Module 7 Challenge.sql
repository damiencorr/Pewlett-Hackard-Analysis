-- Module 7 Challenge
-- Submit the following deliverables:
-- 1. Delivering Results: A README.md in the form of a technical report that details your analysis and findings
-- 2. Technical Analysis Deliverable 1: Number of Retiring Employees by Title. Create three new tables: 1. number of [titles] retiring, 2. number of employees with each title, 3. list of current employees born between Jan. 1, 1952 and Dec. 31, 1955. New tables exported as CSVs. 
-- 3. Technical Analysis Deliverable 2: Mentorship Eligibility. A table containing employees who are eligible for the mentorship program You will submit your table and the CSV containing the data (and the CSV containing the data)

-- 2. Technical Analysis Deliverable 1: Number of Retiring Employees by Title
--- 1. number of [titles] retiring
--- 2. number of employees with each title
--- 3. list of current employees born between Jan. 1, 1952 and Dec. 31, 1955
--- 4. New tables exported as CSVs. 

--- 1. number of [titles] retiring 
-- Create a table containing the number of employees who are about to retire 
--- (those born 1952-1955), grouped by job title. 
--- Use ERD as a reference, create table with an inner join. 
--- table contains the following information:
--- Employee number
--- First and last name
--- Title
--- from_date
--- Salary

SELECT e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	s.salary
-- INTO retiring_by_title
FROM employees as e
INNER JOIN titles as t
ON e.emp_no = t.emp_no
INNER JOIN salaries as s
ON e.emp_no = s.emp_no
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no;
select * from retiring_by_title;

-- Include only most recent title for employees with multiple titles
-- https://blog.theodo.com/2018/01/search-destroy-duplicate-rows-postgresql/
-- Use PARTITION BY to find the emp_no duplicates in titles table! (dividing into emp_no groups)
-- You’ll need to use the code provided below to complete the partition portion of the query. You’ll notice that some of the areas are blank—that’s where you’ll plug in the column headers that you want included from each table.
-- Partition the data to show only most recent title per employee
SELECT ______,
 __________,
 _________,
 _______,
 _____
INTO nameyourtable
FROM
 (SELECT ______,
 __________,
 _________,
 _______,
 _____, ROW_NUMBER() OVER
 (PARTITION BY (emp_no)
 ORDER BY to_date DESC) rn
 FROM __________
 ) tmp WHERE rn = 1
ORDER BY emp_no;

--DROP TABLE retirement_by_current_title;
SELECT
	emp_no,
	first_name,
	last_name,
	title,
	from_date,
	salary --,
	--rn
INTO retirement_by_current_title
FROM(
	SELECT 
		e.emp_no,
		e.first_name,
		e.last_name,
		t.title,
		t.from_date,
		s.salary,
		ROW_NUMBER() OVER (
		PARTITION BY (e.emp_no) 
		ORDER BY t.from_date DESC) as rn
	FROM employees as e
	INNER JOIN titles as t
	ON e.emp_no = t.emp_no
	INNER JOIN salaries as s
	ON e.emp_no = s.emp_no
	WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
) as tmp WHERE rn = 1
ORDER BY emp_no;
