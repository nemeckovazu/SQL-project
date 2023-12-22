CREATE TABLE t_zuzana_nemeckova_project_SQL_primary_final
SELECT
	cpc.code AS food_category_code,
	cpc.name AS food_category,
	cp.value AS food_price,
	cpc.price_value,
	cpc.price_unit,
	DATE_FORMAT(cp.date_from, '%d.%m.%Y') AS price_measured_from,
    DATE_FORMAT(cp.date_to, '%d.%m.%Y') AS price_measured_to,
	cpib.code AS industry_code,
    cpib.name AS industry,
	cp2.value AS average_wages,
	cp2.payroll_year
FROM
	czechia_price cp
JOIN czechia_payroll cp2 
	ON
	YEAR(cp.date_from) = cp2.payroll_year
	AND cp2.value_type_code = 5958
	AND cp.region_code IS NULL
	AND cp2.calculation_code = 200
	AND cp2.payroll_quarter = 1
LEFT JOIN czechia_price_category cpc 
	ON
	cpc.code = cp.category_code
LEFT JOIN czechia_payroll_industry_branch cpib 
	ON
	cp2.industry_branch_code = cpib.code
LEFT JOIN czechia_region cr 
	ON
	cr.code = cp.region_code;

