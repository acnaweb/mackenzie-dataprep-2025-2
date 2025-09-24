-- Fato agregado diário de pedidos
select
  date(order_ts) as order_date,
  channel,
  count(distinct order_id) as orders,
  sum(amount_brl) as revenue_brl,
  count(distinct customer_id) as unique_customers
from {{ ref('stg_orders') }}
group by 1, 2