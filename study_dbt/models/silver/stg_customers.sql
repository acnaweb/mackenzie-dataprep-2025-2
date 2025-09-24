with base as (
  select 
    customer_id,
    initcap(full_name) as full_name,
    lower(email) as email,
    regexp_replace(coalesce(phone,''), '\D', '', 'g') as phone,
    zipcode,
    created_at
  from {{ ref('raw_customers') }}
),
dedup as (
  select *
  from (
    select
      b.*,
      row_number() over (partition by customer_id order by created_at desc nulls last) as rn
    from base b
  ) x
  where rn = 1
),
geo as (
  select zipcode, city, state, region
  from {{ ref('raw_geo_zipcode') }}
)
select
  d.customer_id,
  d.full_name,
  d.email,
  d.phone,
  d.zipcode,
  g.city,
  g.state,
  g.region,
  d.created_at
from dedup d
left join geo g on d.zipcode:: text = g.zipcode::text