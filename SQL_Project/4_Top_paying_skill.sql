/*
Question : What are the top skills based on salary?
- Look at the average salary associated with each skill for our desired positionss
- Focuses on roles with specified salaries, regardless on location
- Why? It reveals how different skills impact salary levels for desired roles and
    helps identify the most financially rewarding skills to acquire or improve
*/

SELECT 
    skills,
    ROUND(AVG(salary_year_avg)) AS salary_skill
FROM job_postings_fact
INNER JOIN skills_job_dim
    ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    (job_title_short = 'Data Analyst' OR job_title_short = 'Data Scientist')
    -- AND job_location LIKE 'Indonesia'
    AND salary_year_avg IS NOT NULL
GROUP BY
    skills
ORDER BY
    salary_skill DESC
LIMIT 10;

/*
Top Paying Skills for Data Analyst and Data Scientist in 2023

[
  {
    "skills": "redhat",
    "salary_skill": "189500"
  },
  {
    "skills": "elixir",
    "salary_skill": "170824"
  },
  {
    "skills": "lua",
    "salary_skill": "170500"
  },
  {
    "skills": "solidity",
    "salary_skill": "168983"
  },
  {
    "skills": "watson",
    "salary_skill": "166545"
  },
  {
    "skills": "rshiny",
    "salary_skill": "166436"
  },
  {
    "skills": "objective-c",
    "salary_skill": "164500"
  },
  {
    "skills": "dplyr",
    "salary_skill": "160667"
  },
  {
    "skills": "haskell",
    "salary_skill": "157500"
  },
  {
    "skills": "hugging face",
    "salary_skill": "157176"
  }
]

Key Takeaways:

💰 Niche skills (RedHat, Elixir, Lua) offer top pay.

🤖 AI/NLP tools (Watson, Hugging Face) are highly valued.

📊 R ecosystem (RShiny, dplyr) still holds strong.

🧠 Blockchain (Solidity) and rare languages (Haskell) show high potential.
*/