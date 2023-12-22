--  VO2: Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?

SELECT
	tznpspf.food_category,
	tznpspf.food_price,
	tznpspf.payroll_year,
	tznpspf.average_wages,
	round((tznpspf.average_wages/tznpspf.food_price), 1) AS food_amount,
	tznpspf.price_unit
FROM
	t_zuzana_nemeckova_project_sql_primary_final tznpspf 
WHERE 
	tznpspf.food_category_code IN ('114201','111301') AND 
	tznpspf.payroll_year IN ('2006','2018')
GROUP BY
	tznpspf.food_category,
	tznpspf.payroll_year
ORDER BY
	tznpspf.food_category;