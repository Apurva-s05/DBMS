CREATE DATABASE emp2;
USE emp2;

CREATE TABLE employee(
   emp_id INT PRIMARY KEY,
   first_name VARCHAR(40),
   last_name VARCHAR(40),
   birth_date DATE,
   sex VARCHAR(1),
   salary INT,
   super_id INT,
   branch_id INT
);

CREATE TABLE branch(
     branch_id INT PRIMARY KEY,
     branch_name VARCHAR(40),
     mgr_id INT ,
     mgr_start_date DATE,
     FOREIGN KEY(mgr_id) REFERENCES employee(emp_id) ON DELETE SET NULL
);

ALTER TABLE employee
ADD FOREIGN KEY(branch_id)
REFERENCES branch(branch_id)
ON DELETE SET NULL;

ALTER TABLE employee
ADD FOREIGN KEY(super_id)
REFERENCES employee(emp_id)
ON DELETE SET NULL;

CREATE TABLE client(
      client_id INT PRIMARY KEY,
      client_name VARCHAR(40),
      branch_id INT,
      FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL
);

CREATE TABLE works_with(
     emp_id INT,
     client_id INT,
	 total_sales INT,
	 PRIMARY KEY(emp_id, client_id),
     FOREIGN KEY(emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE,
	 FOREIGN KEY(client_id) REFERENCES client(client_id) ON DELETE CASCADE
);

CREATE TABLE branch_supplier(
     branch_id INT,
     supplier_name VARCHAR(40),
     supply_type VARCHAR(40),
     PRIMARY KEY (branch_id,supplier_name),
     FOREIGN KEY (branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE
);
-- -----------------------------------------------------------------------------

-- Corporate
INSERT INTO employee VALUES(100, 'Apurva', 'Sarode', '2021-07-14', 'M', 250000, NULL, NULL);

INSERT INTO branch VALUES(1, 'Corporate', 100, '2006-11-05');
UPDATE employee
SET branch_id = 1
WHERE emp_id = 100;

INSERT INTO employee VALUES(101, 'Gaurav', 'Patil', '2019-05-13', 'M', 50000, 100, 1);

-- Scranton
INSERT INTO employee VALUES(102, 'Shreya', 'Joshi', '1997-11-02', 'F', 7000, 100, NULL);

INSERT branch VALUES(2, 'Scranton', 102, '1996-04-06');
UPDATE employee
SET branch_id = 2
WHERE emp_id = 102;

INSERT INTO employee VALUES(103,'Mansi','Dugad','1980-06-02','F',47000,102,2);
INSERT INTO employee VALUES(104,'Kelly','Shah','2000-08-02','F',78000,102,2);
INSERT INTO employee VALUES(105,'Angelina','Martin','2001-04-11','F',9000,102,2);

-- Stamford
INSERT INTO employee VALUES(106, 'Josh', 'Porter', '1969-09-05', 'M', 78000, 100, NULL);

INSERT INTO branch VALUES(3, 'Stamford', 106, '1998-02-13');
UPDATE employee
SET branch_id = 3
WHERE emp_id = 106;

INSERT INTO employee VALUES(107, 'Andy', 'Bernard', '1973-07-22', 'M', 65000, 106, 3);

INSERT INTO employee VALUES(108, 'Jim', 'Halpert', '1978-10-01', 'M', 71000, 106, 3);

-- Branch Supplier
INSERT INTO branch_supplier VALUES(2, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Patriot Paper', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'J.T. Forms & Labels', 'Custom Forms');
INSERT INTO branch_supplier VALUES(3, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(3, 'Stamford Lables', 'Custom Forms');

-- CLIENT
INSERT INTO client VALUES(400, 'Dunmore Highschool', 2);
INSERT INTO client VALUES(401, 'Lackawana Country', 2);
INSERT INTO client VALUES(402, 'FedEx', 3);
INSERT INTO client VALUES(403, 'John Daly Law, LLC', 3);
INSERT INTO client VALUES(404, 'Scranton Whitepages', 2);
INSERT INTO client VALUES(405, 'Times Newspaper', 3);
INSERT INTO client VALUES(406, 'FedEx', 2);

-- Works_with
INSERT INTO works_with VALUES(105, 400, 55000);
INSERT INTO works_with VALUES(102, 401, 267000);
INSERT INTO works_with VALUES(108, 402, 22500);
INSERT INTO works_with VALUES(107, 403, 5000);
INSERT INTO works_with VALUES(108, 403, 12000);
INSERT INTO works_with VALUES(105, 404, 33000);
INSERT INTO works_with VALUES(107, 405, 26000);
INSERT INTO works_with VALUES(102, 406, 15000);
INSERT INTO works_with VALUES(105, 406, 130000);

SELECT * FROM employee;
SELECT * FROM works_with;
SELECT * FROM branch_supplier; 

-- --------------------------------------------------------------------------------------------------------------------------
--                                                          Functions                                                      --

-- 1.Finding Number of employees
SELECT COUNT(emp_id)
FROM employee;

-- 2. Finding number of female born after 1970
SELECT COUNT(emp_id)
FROM employee
WHERE sex = 'F' AND birth_date > '1970-01-01';

-- 3.Average of man employee salary
SELECT AVG(salary)
FROM employee
WHERE sex = 'M';

-- 4.Sum of man employee salary
SELECT SUM(salary)
FROM employee

-- 5.Number of males and females
SELECT COUNT(sex), sex
FROM employee
GROuP BY sex;

-- 6.Total sales by each salesman
SELECT SUM(total_sales), emp_id
FROM works_with
GROUP BY emp_id; 

-- -------------------------------------------------------------------------------------------------------------------------
--                                                      wildcards                                                         --

-- % means any # characters
-- _ means one character

-- 1.Find any clients who are an LLC
SELECT *
FROM client
WHERE client_name LIKE '%LLC';

-- 2. Find any branch supplier who are in the label business
SELECT *
FROM branch_supplier
WHERE supplier_name LIKE '%Label%';

-- 3. Find any employee born in october(10th month)
SELECT *
FROM employee
WHERE birth_date LIKE '____-10%';   

-- -------------------------------------------------------------------------------------------------------------------------
--                                                    Union                                                               --
-- 1. Find list of employee and branch names
SELECT first_name AS Company_name
FROM employee
UNION
SELECT branch_name 
FROM branch; 

-- 2.List of clients and branch suppliers with branch id
SELECT client_name, client.branch_id
FROM client
UNION
SELECT supplier_name, branch_supplier.branch_id
FROM branch_supplier;

