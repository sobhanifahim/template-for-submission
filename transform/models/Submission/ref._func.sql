{{ config(
    materialized='table',
    description='Combined data model with q1 and q3'
) }}


WITH GMVbyCountry AS (
    SELECT * FROM {{ ref('q1') }}
),

TopActiveVendor AS (
    SELECT * FROM {{ ref('q3') }}
)

SELECT
    y.country_name,
    y.vendor_name,
    y.total_gmv AS Top_Active_Vendor_GMV,
	x.total_gmv AS Total_GMV_Per_Country
FROM
    q1 x
JOIN
    q3 y ON x.country_name = y.country_name;