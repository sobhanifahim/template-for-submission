{{
    config(
        materialized='table'
    )
}}

WITH Top2VendorPerCountryEachYear AS (
    WITH Top2VendorsPerCountry AS (
    SELECT
        v.country_name,
        v.vendor_name,
        o.date_local AS order_year,
        ROUND(SUM(o.gmv_local),2) AS total_gmv,
        RANK()OVER (PARTITION BY v.country_name,o.date_local ORDER BY SUM(o.gmv_local) DESC) AS TopVendors
    FROM
        `dbt-task.foodpanda.vendors` v
    JOIN
        `dbt-task.foodpanda.order` o ON v.id = o.vendor_id 
    GROUP BY
        v.country_name, v.vendor_name, o.date_local
    ORDER BY o.date_local ASC
)
SELECT
    EXTRACT(YEAR FROM order_year) AS year,
    country_name,
    vendor_name,
    total_gmv
FROM
    Top2VendorsPerCountry
WHERE
    TopVendors <= 2;
)

SELECT * FROM Top2VendorPerCountryEachYear;