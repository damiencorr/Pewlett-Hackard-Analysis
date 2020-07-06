-- Creating tables for PH-EmployeeDB
CREATE TABLE departments (
     dept_no VARCHAR(4) NOT NULL,
     dept_name VARCHAR(40) NOT NULL,
     PRIMARY KEY (dept_no),
     UNIQUE (dept_name)
);

CREATE TABLE employees (
     emp_no INT NOT NULL,
     birth_date DATE NOT NULL,
     first_name VARCHAR NOT NULL,
     last_name VARCHAR NOT NULL,
     gender VARCHAR NOT NULL,
     hire_date DATE NOT NULL,
     PRIMARY KEY (emp_no)
);

CREATE TABLE dept_manager (
    dept_no VARCHAR(4) NOT NULL,
    emp_no INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
-- Unique requires from_date to cover manager joining d1, leaving d1 for d2, then rejoining d1 again on a new date
    PRIMARY KEY (emp_no, dept_no, from_date)
);

CREATE TABLE salaries (
    emp_no INT NOT NULL,
    salary INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
-- Unique requires from_date to cover emp salary changing from s1 to s2 on a day
    PRIMARY KEY (emp_no, from_date)
);

CREATE TABLE titles (
    emp_no int   NOT NULL,
    title varchar   NOT NULL,
    from_date date   NOT NULL,
    to_date date   NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
-- Unique requires from_date to cover emp title being set to 1, then being changed to t2, then being changed back to t1
    PRIMARY KEY (emp_no, title, from_date)
);

CREATE TABLE dept_emp (
    emp_no int   NOT NULL,
    dept_no varchar (4)  NOT NULL,
    from_date date   NOT NULL,
    to_date date   NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
-- Unique requires from_date to cover emp joing dept d1, then leaving for d2, then returning back to d1 each on a new day
    PRIMARY KEY (emp_no, dept_no, from_date)
);

