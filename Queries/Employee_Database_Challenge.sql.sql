
--Merge employees and titles and retrieve list of retirees by title
SELECT
e.emp_no,
e.first_name,
e.last_name,
ti.title,
ti.from_date,
ti.to_date
INTO retirees_by_title
FROM titles as ti
LEFT JOIN employees AS e
ON (ti.emp_no = e.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no;

--Retrieve retirees currently employed, and by their most recent title
SELECT DISTINCT ON (emp_no) 
rt.emp_no,
rt.first_name,
rt.last_name,
rt.title
INTO unique_titles
FROM retirees_by_title as rt
WHERE (rt.to_date = '9999-01-01')
ORDER BY emp_no, rt.to_date DESC;

--Retrieve list of titles and count of retiring employees with that title
SELECT title, COUNT(title)
INTO retiring_titles
From unique_titles
GROUP BY (title)
ORDER BY count DESC

--Create a Mentorship Eligibility table for current employees born between 1/1/1965 and 12/31/1965
SELECT DISTINCT ON (emp_no)
e.emp_no,
e.first_name,
e.last_name,
e.birth_date,
de.from_date,
de.to_date,
ti.title
INTO mentorship_eligibility
FROM employees as e
LEFT JOIN dept_employees as de
ON (de.emp_no = e.emp_no)
LEFT JOIN titles as ti
ON (ti.emp_no = e.emp_no)
WHERE  (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	AND (de.to_date = '9999-01-01')
ORDER BY emp_no;