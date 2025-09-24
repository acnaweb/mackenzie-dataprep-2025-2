-- Fato de pagamentos
select
  p.payment_id,
  o.order_id,
  o.customer_id,
  p.method,
  p.status,
  p.paid_amount_brl,
  p.paid_at
from {{ ref('stg_payments') }} p
join {{ ref('stg_orders') }} o
  on p.order_id = o.order_id