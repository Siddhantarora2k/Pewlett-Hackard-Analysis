-- Employees who are about to retire
SELECT e.emp_no, e.first_name,
e.last_name,
ti.title,
ti.from_date,
ti.to_date
INTO retire_title
FROM employees as e
INNER JOIN titles as ti
ON (e.emp_no = ti.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
rt.first_name,
rt.last_name,
rt.title
INTO uni_titles
FROM retire_title AS rt
ORDER BY rt.emp_no, rt.to_date DESC;

-- EMployees retiring soon and recent job
SELECT COUNT(title), title
INTO retiring_uni_titles
FROM uni_titles
GROUP BY title
ORDER BY COUNT(title) DESC;

-- Deliverable 2
-- Employees eligible for mentorship program
SELECT DISTINCT ON (e.emp_no) e.emp_no,
e.first_name,
e.last_name,
e.birth_date,
de.from_date,
de.to_date,
ti.title
INTO mentor_emp
FROM employees as e
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles AS ti
ON (e.emp_no = ti.emp_no)
WHERE ((de.to_date = '01-01-99') AND (e.birth_date BETWEEN
	   '1965-01-01' AND '1965-12-31'))
