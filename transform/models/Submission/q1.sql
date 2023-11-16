{{
    config(
        materialized='table'
    )
}}

WITH GMVbyEachCountry AS (
     SELECT country_name,ROUND(SUM(gmv_local),2) as total_gmv
	 FROM `dbt-task.foodpanda.order` 
	 GROUP BY country_name;
)

SELECT * FROM GMVbyEachCountry;