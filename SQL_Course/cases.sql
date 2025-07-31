SELECT
    job_title_short,
    job_location
FROM
    job_postings_fact
LIMIT 5;

/*
Label new column as follows:
- 'Anywhere' jobs as 'Remote'
- 'New York, NY' jobs as 'Local'
- Others as 'Onsite' */

SELECT
    job_title_short,
    job_location,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM
    job_postings_fact;

-- Number of jobs of location category and data analyst jobs
SELECT
    count(job_id) AS number_of_jobs,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    location_category;

-- Problem 1
SELECT
    salary_year_avg::REAL,
    CASE
        WHEN salary_year_avg BETWEEN 0 AND 50000 THEN 'Low'
        WHEN salary_year_avg BETWEEN 50001 AND 150000 THEN 'Standard'
        ELSE 'HIGH'
    END AS salary_category
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
ORDER BY
    salary_year_avg DESC;