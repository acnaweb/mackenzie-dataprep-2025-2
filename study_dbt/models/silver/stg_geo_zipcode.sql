-- Normalização básica de CEPs
select
  zipcode,
  initcap(city) as city,
  upper(state) as state,
  initcap(region) as region
from {{ ref('raw_geo_zipcode') }}