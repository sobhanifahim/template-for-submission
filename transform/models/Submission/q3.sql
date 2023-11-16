{{
    config(
        materialized='table'
    )
}}

WITH TopActiveVendorbyGMV AS (
    WITH TopActive AS (
    SELECT
        v.country_name,
        v.vendor_name,
        ROUND(SUM(o.gmv_local),2) AS total_gmv,
        RANK()OVER (PARTITION BY v.country_name ORDER BY SUM(o.gmv_local) DESC) AS top_vendor
    FROM
         `dbt-task.foodpanda.vendors` v
    JOIN
        `dbt-task.foodpanda.order` o ON v.id = o.vendor_id 
	WHERE 
	  v.is_active=TRUE
    GROUP BY
        v.country_name, v.vendor_name
)
SELECT
    country_name,
    vendor_name,
    total_gmv
FROM
    TopActive
WHERE
    top_vendor = 1;
)

SELECT * FROM TopActiveVendorbyGMV;