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
	title  as current_title,
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

-- 1. number of [titles] retiring
-- Provide a count of the number of titles retiring
--DROP TABLE retirement_title_count;
SELECT COUNT(DISTINCT title) as count_of_distinct_titles
INTO retirement_title_count
FROM retirement_by_current_title;

-- 2. number of employees with each title
-- Provide a count BY TITLE of number of employees retiring
--DROP TABLE retirement_count_emp_by_title;
SELECT title, Count(*) as emp_count_per_title
INTO retirement_count_emp_by_title
FROM retirement_by_current_title
GROUP BY title;

-- 3. list of current employees born between Jan. 1, 1952 and Dec. 31, 1955
--- See results for table retirement_by_current_title




-- Deliverable 2: Mentorship Eligibility
--- include the following information:
--- Employee number
--- First and last name
--- Title
--- from_date and to_date
-- To be eligible to participate in the mentorship program, employees will need 
--- a date of birth between January 1, 1965 and December 31, 1965. 
--- You’ll need to use two inner joins to create this new table. 
--- Refer to ERD for tables containing the required info.
-- BEFORE EXPORT - Check for duplicates before creating a CSV!
--- export the data as a CSV and push it to your repository.

-- Find employees with birthdate in range Jan 1 to Dec 31 1965
--- AND to_date = 9999-01-01 indicating CURRENT EMPLOYEES ONLY and also current title!!!!

--DROP TABLE mentorship_eiligibility;
SELECT
	emp_no,
	first_name,
	last_name,
	title as current_title,
	from_date,
	to_date --,
	--birth_date,
	--rn
INTO mentorship_eiligibility
FROM(
	SELECT 
		e.emp_no,
		e.first_name,
		e.last_name,
		t.title,
		t.from_date,
		t.to_date,
		--e.birth_date,
		ROW_NUMBER() OVER (
		PARTITION BY (e.emp_no) 
		ORDER BY t.from_date DESC) as rn
	FROM employees as e
	INNER JOIN titles as t
	ON e.emp_no = t.emp_no
	WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
) as tmp 
WHERE 
-- Get the first row of each emp_no group with most recent title
rn = 1 and 
-- Get row ONLY if to_date indicates a CURRENT EMPLOYEE!!
to_date = '9999-01-01'
ORDER BY emp_no;