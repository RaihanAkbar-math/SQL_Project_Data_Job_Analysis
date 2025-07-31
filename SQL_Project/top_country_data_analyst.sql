-- Here are the top 25 country for Data Analyst

SELECT
    job_country,
    ROUND(AVG(salary_year_avg)) AS average_salary,
    COUNT(job_id) AS job_count
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_country IS NOT NULL
GROUP BY
    job_country
ORDER BY
    average_salary DESC,
    job_count DESC
LIMIT 25;