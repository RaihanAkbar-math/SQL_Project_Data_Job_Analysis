/*
What are the top-paying jobs for my desired role?
    - Identify the top 10 highest-paying Data Analyst and Data Scientist roles that are available in Indonesia.
    - Focuses on job postings with specified salaries (remove nulls)
    - Why? Highlight the top-paying opportunities for Data Analysts and Data Scientist, offering insights
*/

SELECT
    job_id,
    job_title,
    company_dim.name AS company_name,
    job_location,
    job_schedule_type,
    salary_year_avg AS salary_yearly_USD,
    job_posted_date
FROM
    job_postings_fact
LEFT JOIN company_dim
    ON job_postings_fact.company_id = company_dim.company_id
WHERE
    (job_title_short = 'Data Analyst' OR job_title_short = 'Data Scientist')
    AND
    job_location like '%Indonesia%'
    AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;