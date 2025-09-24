-- Fato de itens de pedidos
select
  i.order_id,
  o.customer_id,
  i.product_id,
  i.quantity,
  i.unit_price,
  (i.quantity * i.unit_price)::numeric as gross_item_amount,
  o.amount_brl as order_amount_brl,
  o.order_ts,
  o.channel
from {{ ref('stg_order_items') }} i
join {{ ref('stg_orders') }} o
  on i.order_id = o.order_id