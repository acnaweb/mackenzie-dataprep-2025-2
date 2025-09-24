-- Fato de KPIs de clientes
select
  customer_id,
  count(distinct order_id) as num_orders,
  sum(amount_brl) as total_spent_brl,
  avg(amount_brl) as avg_order_value_brl
from {{ ref('stg_orders') }}
group by customer_id