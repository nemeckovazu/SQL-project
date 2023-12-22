-- Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem?

SELECT 
	tp.payroll_year, 
	round(AVG(tp.food_price)) AS avg_food_price, 
	round(AVG(tp.average_wages)) AS average_wages, 
	round((AVG(tp.food_price) - lag(avg(tp.food_price)) OVER (ORDER BY tp.payroll_year)) / lag(avg(tp.food_price)) 
    	OVER (ORDER BY tp.payroll_year) * 100, 2) AS food_price_increase_percentage, 
    	round((AVG(tp.average_wages) - lag(avg(tp.average_wages)) OVER (ORDER BY tp.payroll_year)) / lag(avg(tp.average_wages)) 
    	OVER (ORDER BY tp.payroll_year) * 100, 2) AS avg_wages_increase_percentage, 
    	round((AVG(tp.food_price) - lag(avg(tp.food_price)) OVER (ORDER BY tp.payroll_year)) / lag(avg(tp.food_price)) 
    	OVER (ORDER BY tp.payroll_year) * 100, 2) -
    	round((AVG(tp.average_wages) - lag(avg(tp.average_wages)) OVER (ORDER BY tp.payroll_year)) / lag(avg(tp.average_wages)) 
    	OVER (ORDER BY tp.payroll_year) * 100, 2) AS difference_percentage, tp2.GDP, 
    	round((AVG(tp2.GDP) - lag(avg(tp2.GDP)) OVER (ORDER BY tp2.GDP)) / lag(avg(tp2.GDP)) 
    	OVER (ORDER BY tp.payroll_year) * 100, 2) AS gdp_increase_percentage
FROM t_zuzana_nemeckova_project_sql_primary_final tp
LEFT JOIN t_zuzana_nemeckova_projekt_sql_secondary_final tp2
	ON tp.payroll_year = tp2.year
WHERE tp.payroll_year BETWEEN 2006 AND 2018
GROUP BY tp.payroll_year;