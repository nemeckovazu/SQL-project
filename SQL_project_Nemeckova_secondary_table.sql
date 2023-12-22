CREATE TABLE t_zuzana_nemeckova_projekt_SQL_secondary_final AS
SELECT 
	e.country, 
	e.year, 
	e.GDP,
	e.gini,
	e.population
FROM economies e
LEFT JOIN countries c ON e.country = c.country
WHERE e.GDP IS NOT NULL;