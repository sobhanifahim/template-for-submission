{{
    config(
        materialized='table'
    )
}}

WITH GMVvendorsOfTaiwan AS {
     SELECT v.vendor_name,COUNT(DISTINCT(o.customer_id)) AS customer_count, SUM(o.gmv_local) AS total_gmv
	 FROM `dbt-task.foodpanda.order` o join  `dbt-task.foodpanda.vendors` v
	 ON v.id=o.vendor_id
	 WHERE v.country_name='Taiwan'
	 GROUP BY v.vendor_name
	 ORDER BY customer_count DESC
}
SELECT * FROM GMVvendorsOfTaiwan;