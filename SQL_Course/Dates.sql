-- Make sure the data loaded well
SELECT job_posted_date
FROM job_postings_fact 
LIMIT 10;

-- Column Type
SELECT 
    '2023-02-19'::DATE,
    '789'::INTEGER,
    'TRUE'::BOOLEAN,
    '2.71'::REAL;

--Change the data type as we want
SELECT
    job_title_short AS title,
    job_location AS location,
    job_posted_date::DATE AS date
FROM
    job_postings_fact
LIMIT 20;

/* Change date type to AT TIME ZONE like 'UTC' or 'EST'
UTC and EST have 5 hours different */
SELECT
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time
FROM
    job_postings_fact
LIMIT 5;

/* Adding month and year columns */
SELECT
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time,
    EXTRACT(MONTH FROM job_posted_date) AS date_month,
    EXTRACT(YEAR FROM job_posted_date) AS date_year
FROM
    job_postings_fact
LIMIT 5;

-- Trend jobs over months
SELECT
    count(job_id) AS job_count,
    EXTRACT(month from job_posted_date) as month
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    month
ORDER BY
    job_count DESC;

/* Problem 1 : Write a query to find the average salary both yearly and hourly
for job postings that were posted after June 1, 2023. Group the results by job schedule type. */
SELECT
    job_schedule_type,
    AVG(salary_year_avg) AS salary_yearly,
    AVG(salary_hour_avg) AS salary_hourly
FROM
    job_postings_fact
WHERE
    job_posted_date::DATE > '2023-06-01'
GROUP BY
    job_schedule_type;


/* Problem 2 : Write a query to count the number of job postings for each month in 2023, adjusting
the job_posted_date to be in 'America/New_York' time zone before extracting the month.
Assume the job_posted_date is stored in UTC. Group by and order by the month. */
SELECT
    EXTRACT(MONTH FROM job_posted_date AT TIME ZONE 'UTC') AS date_month,
    COUNT(job_id) AS job_count
FROM
    job_postings_fact
GROUP BY
    date_month
ORDER BY
    date_month;

/* Problem 3 : Write a query to find companies (include company name) that have posted jobs offering health insurance,
where these postings were made in the second quarter of 2023. Use data extraction
to filter by quarter. */
SELECT
    EXTRACT(MONTH FROM job_posted_date) AS month,
    job_health_insurance,
    companies.name
FROM
    job_postings_fact
LEFT JOIN company_dim AS companies
    ON job_postings_fact.company_id=companies.company_id
WHERE
    EXTRACT(MONTH FROM job_posted_date) > 6 and
    job_health_insurance='TRUE'
ORDER BY
    month;