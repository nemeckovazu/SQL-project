-- Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?

SELECT * FROM (
SELECT 
	tznpspf.food_category,
	tznpspf.payroll_year,
	round(avg(tznpspf.food_price) , 2) AS avg_food_price,
	tznpspf.average_wages,
	t2.payroll_year AS payroll_year_prev,
	round(t2.food_price , 2) AS avg_food_price_prev,
	t2.average_wages AS average_wages_prev,
CASE WHEN t2.payroll_year IS NULL THEN NULL
	ELSE round((((avg(tznpspf.food_price) - t2.food_price) / t2.food_price) * 100) , 1)
	END AS YoY_food_price_growth_percent,
CASE WHEN t2.average_wages IS NULL THEN NULL
	ELSE round((((tznpspf.average_wages - t2.average_wages) / t2.average_wages) * 100) , 1)
	END AS YoY_wages_growth_percent,
CASE WHEN (t2.payroll_year IS NULL OR t2.average_wages IS NULL) THEN NULL
	ELSE round((((avg(tznpspf.food_price) - t2.food_price) / t2.food_price) * 100) , 1) - round((((tznpspf.average_wages - t2.average_wages) / t2.average_wages) * 100) , 1)
	END AS diference
FROM
    t_zuzana_nemeckova_project_sql_primary_final tznpspf 
    LEFT JOIN (
    	SELECT 
    		tznpspf2.food_category,
    		tznpspf2.payroll_year,
    		avg(tznpspf2.food_price) AS food_price,
    		tznpspf2.average_wages
    	FROM 
    		t_zuzana_nemeckova_project_sql_primary_final tznpspf2 
    	GROUP BY 
    		tznpspf2.food_category,
    		tznpspf2.payroll_year
    ) t2 ON t2.food_category = tznpspf.food_category AND tznpspf.payroll_year = (t2.payroll_year + 1)
GROUP BY 
	tznpspf.food_category,
	tznpspf.payroll_year
) x
WHERE x.diference >= 10;