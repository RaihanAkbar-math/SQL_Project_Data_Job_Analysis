/*
Find job postings from the first quarter that have a salary greater than $70K
- Combine job posting tables from the first quarter of 2023 (Jan-Mar)
- Gets job postings with an average yearly salary > $70,000
*/

SELECT 
    job_title_short,
    job_location,
    job_via,
    job_posted_date::DATE,
    salary_year_avg
FROM (
    SELECT *
    FROM job_january
    UNION ALL
    SELECT *
    FROM job_february
    UNION ALL
    SELECT *
    FROM job_march
) AS q1_job_postings
WHERE
    salary_year_avg > 70000 AND
    job_title_short = 'Data Analyst'
ORDER BY
    salary_year_avg DESC
LIMIT 10;