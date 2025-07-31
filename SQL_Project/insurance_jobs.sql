/*
Goal : I want to know the most job postings company for Data Analytics or Data Scientist 
and they offer health insurance for it.
*/

SELECT
    company_dim.company_id,
    company_dim.name,
    company_dim.link,
    COUNT(job_postings.job_id) AS job_count
FROM 
    job_postings_fact AS job_postings
LEFT JOIN company_dim
    ON job_postings.company_id = company_dim.company_id
WHERE
    job_health_insurance = TRUE AND
    (job_title_short = 'Data Analyst' OR job_title_short = 'Data Scientist')
GROUP BY
    company_dim.company_id
ORDER BY
    job_count DESC
LIMIT 10;

/*

📊 Insight: Top Companies Hiring Data Analysts/Scientists with Health Insurance (2023)
[
  {
    "company_id": 49,
    "name": "Booz Allen Hamilton",
    "link": "http://www.boozallen.com/",
    "job_count": "1658"
  },
  {
    "company_id": 143,
    "name": "Guidehouse",
    "link": null,
    "job_count": "1224"
  },
  {
    "company_id": 152,
    "name": "UnitedHealth Group",
    "link": "https://www.unitedhealthgroup.com/",
    "job_count": "826"
  },
  {
    "company_id": 367,
    "name": "Walmart",
    "link": "https://www.walmart.com/",
    "job_count": "747"
  },
  {
    "company_id": 463,
    "name": "Corporate",
    "link": null,
    "job_count": "419"
  },
  {
    "company_id": 1500,
    "name": "Centene Corporation",
    "link": "http://www.centene.com/",
    "job_count": "384"
  },
  {
    "company_id": 2686,
    "name": "Get It Recruit - Information Technology",
    "link": null,
    "job_count": "324"
  },
  {
    "company_id": 1883,
    "name": "Kforce",
    "link": "http://www.kforce.com/",
    "job_count": "272"
  },
  {
    "company_id": 797,
    "name": "Robert Half",
    "link": "http://www.rhi.com/",
    "job_count": "255"
  },
  {
    "company_id": 2456,
    "name": "Apple",
    "link": "http://www.apple.com/",
    "job_count": "248"
  }
]

In 2023, several major companies showed strong demand for Data Analyst and Data Scientist roles while offering health insurance benefits. Here's what stands out:

Booz Allen Hamilton leads the chart with 1,658 job postings, emphasizing their large-scale hiring and commitment to employee well-being.

Guidehouse and UnitedHealth Group follow, with 1,224 and 826 postings respectively—highlighting opportunities in consulting and healthcare sectors.

Tech and retail giants like Apple and Walmart also made the list, showcasing data roles across diverse industries.

Companies like Kforce and Robert Half reflect the significant role of recruitment/staffing firms in placing data professionals.

This data reinforces that employers value data talent and are pairing that with competitive benefits, such as health insurance, to attract top candidates.
*/