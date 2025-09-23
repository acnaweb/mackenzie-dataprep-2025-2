WITH base AS (
    SELECT 
        c.customer_id,
        c.full_name,
        lower(c.email) AS email,
        c.phone,
        c.zipcode,
        c.created_at
    FROM {{ ref('raw_customers') }} AS c
), geo AS (
    SELECT 
        b.customer_id,
        b.full_name,
        b.email,
        b.phone,
        b.zipcode,
        b.created_at,
        g.city,
        g.state,
        g.region
    FROM base AS b
    JOIN {{ ref('raw_geo_zipcode') }} AS g
        ON g.zipcode = b.zipcode
)

SELECT * 
FROM geo;
