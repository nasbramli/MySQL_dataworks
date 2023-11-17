-- 1. Analyse the data
-- Have a generic switch statement to sample the data that you've
-- ****************************************************************
-- SELECT u.user_id, u.email_domain, p.learn_cpp, p.learn_html, p.learn_java, p.learn_javascript, p.learn_sql 
-- FROM users u
-- JOIN progress p
-- ON u.user_id = p.user_id
-- ORDER BY u.email_domain;


-- 2. What are the Top 25 schools (.edu domains)?
-- ****************************************************************
-- SELECT COUNT(email_domain) AS "Number of students", email_domain 
-- FROM users
-- GROUP BY email_domain
-- ORDER BY COUNT(user_id) DESC
-- LIMIT 25;


-- How many .edu learners are located in New York? 
-- ****************************************************************
-- SELECT COUNT(user_id) AS "Number of students", city 
-- FROM users 
-- WHERE city LIKE '%New York%'
-- GROUP BY city;


-- The mobile_app column contains either mobile-user or NULL. 
-- How many of these Codecademy learners are using the mobile app?
-- ****************************************************************
-- SELECT COUNT(*) AS "Number of students", mobile_app 
-- FROM users 
-- WHERE mobile_app IN('mobile-user') GROUP BY mobile_app;

-- ALTERNATE ANSWER #1
-- SELECT COUNT(*) AS "Number of mobile users" 
-- FROM users 
-- WHERE mobile_app IN('mobile-user');

-- ALTERNATE ANSWER #2
-- SELECT COUNT(*) AS "Number of mobile users", mobile_app
-- FROM users 
-- WHERE mobile_app != '' GROUP BY mobile_app;

-- ALTERNATE ANSWER #3
-- SELECT COUNT(*) AS "Number of mobile users"
-- FROM users 
-- WHERE mobile_app != '';


-- 3. (ONLY WORKS IN SQLITE) Query for the sign up counts for each hour.
-- ****************************************************************
-- SELECT COUNT(sign_up_at), strftime('%H', sign_up_at) as "Hour" 
-- FROM USERS
-- GROUP BY strftime('%H', sign_up_at);

-- (ONLY WORKS MYSQL) Query for the sign up counts for each hour.
-- ****************************************************************
-- https://dev.mysql.com/doc/refman/5.7/en/date-and-time-functions.html#function_date-format 
SELECT COUNT(sign_up_at), DATE_FORMAT(sign_up_at, '%H') as "Hour" 
FROM USERS
GROUP BY DATE_FORMAT(sign_up_at, '%H');


-- 4. METHOD #1: Do different schools (.edu domains) prefer different courses?
-- ****************************************************************
-- SELECT email_domain, 
-- SUM(CASE WHEN learn_cpp NOT IN('') THEN 1 ELSE 0 END) AS "C++",
-- SUM(CASE WHEN learn_sql NOT IN('') THEN 1 ELSE 0 END) AS "SQL",
-- SUM(CASE WHEN learn_html NOT IN('') THEN 1 ELSE 0 END) AS "HTML",
-- SUM(CASE WHEN learn_javascript NOT IN('') THEN 1 ELSE 0 END) AS "JS",
-- SUM(CASE WHEN learn_java NOT IN('') THEN 1 ELSE 0 END) AS "JAVA",
-- COUNT(email_domain) AS "NUMBER OF LEARNERS"
-- FROM progress
-- JOIN users ON progress.user_id = users.user_id
-- GROUP BY email_domain
-- ORDER BY email_domain ASC;

-- METHOD #2 (ONLY WORKS IN MYSQL): Do different schools (.edu domains) prefer different courses?
-- SELECT email_domain, 
-- SUM(IF(learn_cpp NOT IN(''), 1, 0)) AS "C++",
-- SUM(IF(learn_sql NOT IN(''), 1, 0)) AS "SQL",
-- SUM(IF(learn_html NOT IN(''), 1, 0)) AS "HTML",
-- SUM(IF(learn_javascript NOT IN(''), 1, 0)) AS "JS",
-- SUM(IF(learn_java NOT IN(''), 1, 0)) AS "JAVA",
-- COUNT(email_domain) AS "NUMBER OF LEARNERS"
-- FROM progress
-- JOIN users ON progress.user_id = users.user_id
-- GROUP BY email_domain
-- ORDER BY email_domain ASC;

-- What courses are the New Yorker Students taking?
-- SELECT 
-- SUM(CASE WHEN learn_cpp NOT IN('') THEN 1 ELSE 0 END) AS "New Yorkers taking C++",
-- SUM(CASE WHEN learn_sql NOT IN('') THEN 1 ELSE 0 END) AS "New Yorkers taking SQL",
-- SUM(CASE WHEN learn_html NOT IN('') THEN 1 ELSE 0 END) AS "New Yorkers taking HTML",
-- SUM(CASE WHEN learn_javascript NOT IN('') THEN 1 ELSE 0 END) AS "New Yorkers taking JS",
-- SUM(CASE WHEN learn_java NOT IN('') THEN 1 ELSE 0 END) AS "New Yorkers taking JAVA"
-- FROM progress
-- JOIN users ON progress.user_id = users.user_id
-- WHERE users.city = "New York";

-- What courses are the Chicago Students taking?
-- SELECT 
-- SUM(CASE WHEN learn_cpp NOT IN('') THEN 1 ELSE 0 END) AS "Chicago learners taking C++",
-- SUM(CASE WHEN learn_sql NOT IN('') THEN 1 ELSE 0 END) AS "Chicago learners taking SQL",
-- SUM(CASE WHEN learn_html NOT IN('') THEN 1 ELSE 0 END) AS "Chicago learners taking HTML",
-- SUM(CASE WHEN learn_javascript NOT IN('') THEN 1 ELSE 0 END) AS "Chicago learners taking JS",
-- SUM(CASE WHEN learn_java NOT IN('') THEN 1 ELSE 0 END) AS "Chicago learners taking JAVA"
-- FROM progress
-- JOIN users ON progress.user_id = users.user_id
-- WHERE users.city = "Chicago";

