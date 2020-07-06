# Pewlett-Hackard-Analysis

## Module7

## Challenge

The Technical Report for the Module 7 Challenge consists of three paragraphs:
- An Introduction
- A summary of the steps taken
- A review of the results with recommended next steps

## Introduction

Bobby’s manager wants information to help prepare for the “silver tsunami” as many current employees reach retirement age. In particular:
- Determine the total number of employees per title who will be retiring, to know who many roles wil need to be filled
- Identify employees who are eligible to participate in a mentorship program, to mentor the next generation of Pewlett Hackard employees.

This analysis provides three deliverables in pursuit of the challenge.

- README.md in the form of a technical report that details the analysis and findings - This Document!

- Technical Analysis Deliverable 1: 
    - Number of Retiring Employees by Title, delivered as three new tables:
        - Number of [titles] retiring
        - Number of employees with each title
        - List of current employees born between Jan. 1, 1952 and Dec. 31, 1955
    - Tables are exported as CSVs - See DATA folder this project!

- Technical Analysis Deliverable 2: 
    - Mentorship Eligibility
        - A table containing employees who are eligible for the mentorship program
    - Table is exported as a CSV


## Summary of Steps Taken

This paragraph summarizes the steps taken to solve the problem, as well as any challenges encountered along the way.

Technical Analysis Deliverable 1:

- Created a table, 'retirement_by_current_title.csv', containing the number of employees who are about to retire
    - In particular those born 1952-1955) and
    - grouped by job title
    - Used the ERD as a reference
    - created table using an inner join between the 'employees', 'titles' & 'salaries' tables
    - Table contains the following data:
        - Employee number, First and last name, Title, from_date, Salary
- This initial approach uncovered multiple duplicates based on titles
    - reflecting that employees change titles over time
    - To address the duplicates, employed the PARTITION BY clause and sorting
        - Partition by the employee ID (emp_no)
        - sorted DESCENDING by the title table's from_date, ensuring the employees most recent title appears first in each emp_no partitioned group
        - Removed the redundant titles from the end result
- Exported the contents of the table as a .CSV file ('retirement_by_current_title.csv') file to the DATA folder
- Finally used the retirement_by_current_title table as the source for the other questions
    - Number of [titles] retiring, exported as 'retirement_title_count.csv'
    - Number of employees with each title, exported as 'retirement_count_emp_by_title.csv'

Technical Analysis Deliverable 2: 

- Created table 'mentorship_eiligibility' with the following data to capture those employees with a birthdate in the year 1965
    - Employee number, First and last name, Title, from_date and to_date
    - As per the previous analysis, the results included employees based on their current title only
    - Additionally filtered out those employees with a current title 'to_date' that occurred in the past, which may indicate that the employee is no longer an actual employee - NEEDS FURTHER INVESTIGATION!
    

## Results of Analysis and Recommended Next Steps

This paragraph summarizes the results of the analysis, discusses the generated data, and recommends next steps.

The Number of Retiring Employees by Title are broken down as follows:
- Number of [titles] retiring = 7
    - See data file 'retirement_title_count.csv'
- Number of employees with each title
    - Engineer = 14,221
    - Senior Engineer = 29,415
    - Manager = 2
    - Assistant Engineer = 1,761
    - Staff = 12,242
    - Senior Staff = 28,255
    - Technique Leader = 4,502
    - see file 'retirement_count_emp_by_title.csv'
- Total Number of current employees born between Jan. 1, 1952 and Dec. 31, 1955
    - 90,399
    - See data file 'retirement_by_current_title.csv'


The Number of employees meeting the Mentorship Eligibility criteria is:
- 1,550
- See data file 'mentorship_eligibility.csv'


Limitations to the analysis

- The number of retiring manager titles seems to be very low compared to other titles, perhaps indicating an issue with the original extraction process that failed to pull all the managers.
- Salaries for employees with changed titles seem to remain the same across title changes, perhaps indicating an extraction process issue that failed to pull relevant salaries for previous titles. 
- There were instances of employees with a current title 'to_date' that were not set to the placeholder '9999-01-01' date. An initial assumption might be that the employee table holds data for employees that have already left the company for some reason.
- The current analysis is a company-wide overview. It will likely be useful to break down the analysis by DEPARTMENT.

Recommended next steps
- Investigate why there seem to be so few managers ready for retirement.
- Investigate if/why 'current' employees might have 'current' titles with to_dates not set to the '9999-01-01" placeholder. 
- Break the analysis down by DEPARTMENT, enabling planning on a per-department basis.
- Review the source extract process to determine why salaries remain unchanged across title changes.


Image of the ERD mapping out the database
- INSERT IMAGE HERE