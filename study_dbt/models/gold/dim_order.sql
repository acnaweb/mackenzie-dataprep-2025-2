-- Dimensão degenerada de pedidos
select
  order_id,
  customer_id,
  order_ts,
  date(order_ts) as order_date,
  channel,
  amount_brl
from {{ ref('stg_orders') }}