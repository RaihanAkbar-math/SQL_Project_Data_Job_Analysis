SELECT *
FROM ( -- SubQuery starts here
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
    ) AS job_january;
-- SubQuery ends here

WITH job_january AS ( -- CTE definition starts here
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
    ) -- CTE definition ends here

SELECT *
FROM job_january;

-- Example
SELECT
    company_id,
    job_no_degree_mention
from
    job_postings_fact
WHERE
    job_no_degree_mention = TRUE

-- SubQuery above example to look what company that fulfill that condition.
SELECT 
    company_id,
    name AS company_name
FROM company_dim
WHERE company_id IN (
    SELECT
        company_id
    from
        job_postings_fact
    WHERE
        job_no_degree_mention = TRUE
    ORDER BY
        company_id
);

-- We want to find what company that have the most job openings
WITH company_job_count AS(
    SELECT
        company_id,
        COUNT(*) AS total_jobs
    FROM
        job_postings_fact
    GROUP BY
        company_id
)

SELECT 
    company_dim.name AS company_name,
    company_job_count.total_jobs
FROM 
    company_dim
LEFT JOIN company_job_count
    ON company_job_count.company_id = company_dim.company_id
ORDER BY
    total_jobs DESC;


-- Problem 1
WITH skill_count AS (
    SELECT
        skill_id,
        COUNT(*) AS total_skills
    FROM
        skills_job_dim
    GROUP BY
        skill_id
)

SELECT 
    skills_dim.skills,
    skill_count.total_skills
FROM skills_dim
LEFT JOIN skill_count
    ON skill_count.skill_id = skills_dim.skill_id
ORDER BY
    total_skills DESC;

-- Problem 2
WITH company_total_jobs AS (
    SELECT 
        COUNT(job_id) AS total_jobs,
        company_dim.name AS company_name
    FROM job_postings_fact
    LEFT JOIN company_dim
        ON company_dim.company_id = job_postings_fact.company_id
    GROUP BY company_dim.name
)

SELECT
    company_name,
    CASE
        WHEN total_jobs < 10 THEN 'Small'
        WHEN total_jobs BETWEEN 10 AND 50 THEN 'Medium'
        ELSE 'Large'
    END AS company_size
FROM company_total_jobs;