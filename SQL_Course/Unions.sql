SELECT  *
FROM job_january

SELECT *
FROM job_february

SELECT *
FROM job_march;

-- UNION combine row wise but not duplicate
-- Get jobs and companies from January
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    job_january

UNION

-- Get jobs and companies from February
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    job_february

UNION

-- Get jobs and companies from March
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    job_march
LIMIT 10;

-- UNION ALL combine row wise even duplicate
-- Get jobs and companies from January
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    job_january

UNION ALL

-- Get jobs and companies from February
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    job_february

UNION ALL

-- Get jobs and companies from March
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    job_march
LIMIT 10;

/* Problem 1 :
- Get the corresponding skill and skill type for each job posting in Q1
- Includes those without any skills, too
- Why? Look at the skills and the type for each job in the first quarter that has a salary >
$70000
*/

WITH jobs_q1 AS (
    SELECT
        job_id, salary_year_avg
    FROM job_january
    UNION ALL
    SELECT
        job_id, salary_year_avg
    FROM job_february
    UNION ALL
    SELECT
        job_id, salary_year_avg
    FROM job_march
)

SELECT
    jobs_q1.job_id,
    skills_dim.skills AS skill,
    skills_dim.type AS skill_type,
    jobs_q1.salary_year_avg AS salary_yearly
FROM
    jobs_q1
LEFT JOIN skills_job_dim
    ON jobs_q1.job_id = skills_job_dim.job_id
LEFT JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    jobs_q1.salary_year_avg > 70000
ORDER BY
    salary_yearly DESC;