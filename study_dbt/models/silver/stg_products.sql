-- Normalização e conversão de preços de produtos
with p as (
  select
    product_id,
    sku,
    initcap(name) as product_name,
    initcap(category) as category,
    price::numeric as price,
    upper(currency) as currency,
    updated_at
  from {{ ref('raw_products') }}
),
fx as (
  select rate_date, currency, rate_to_brl
  from {{ ref('stg_fx_rates') }}
)
select
  p.product_id,
  p.sku,
  p.product_name,
  p.category,
  p.price,
  p.currency,
  p.updated_at,
  (p.price * coalesce(f.rate_to_brl, 1))::numeric as price_brl
from p
left join fx f
  on f.rate_date = date(p.updated_at) and f.currency = p.currency