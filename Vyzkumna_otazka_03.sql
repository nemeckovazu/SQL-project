-- VO3: Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?

SELECT 
	tznpspf.food_category,
	tznpspf.payroll_year,
	round(avg(tznpspf.food_price) , 2) AS average_food_price,
	t2.payroll_year AS payroll_year_prev,
	round(t2.food_price , 2) AS average_food_price_prev,
CASE WHEN t2.payroll_year IS NULL THEN NULL
	ELSE round((((avg(tznpspf.food_price) - t2.food_price) / t2.food_price) * 100) , 1)
	END AS YoY_growth_percent
FROM
    t_zuzana_nemeckova_project_sql_primary_final tznpspf 
    LEFT JOIN (
    	SELECT 
    		tznpspf2.food_category,
    		tznpspf2.payroll_year,
    		avg(tznpspf2.food_price) AS food_price
    	FROM 
    		t_zuzana_nemeckova_project_sql_primary_final tznpspf2 
    	GROUP BY 
    		tznpspf2.food_category,
    		tznpspf2.payroll_year
    ) t2 ON t2.food_category = tznpspf.food_category AND tznpspf.payroll_year = (t2.payroll_year + 1)
GROUP BY 
	tznpspf.food_category,
	tznpspf.payroll_year;