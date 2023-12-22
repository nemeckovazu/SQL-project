 --  VO1: Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
 
 SELECT
	tznpspf.industry,
	tznpspf.payroll_year,
	round(avg(tznpspf.average_wages), 0) AS average_wages
FROM
	t_zuzana_nemeckova_project_sql_primary_final tznpspf 
WHERE 
	tznpspf.industry IS NOT NULL
GROUP BY
	tznpspf.industry,
	tznpspf.payroll_year
ORDER BY
	tznpspf.industry,
	tznpspf.payroll_year ;