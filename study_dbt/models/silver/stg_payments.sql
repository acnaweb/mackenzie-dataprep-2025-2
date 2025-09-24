-- Normalização e enriquecimento de pagamentos
with base as (
  select
    payment_id,
    order_ref,
    lower(method) as method,
    lower(status) as status,
    paid_amount::numeric as paid_amount,
    upper(currency) as currency,
    paid_at
  from {{ ref('raw_payments') }}
),
joined as (
  select
    b.payment_id,
    o.order_id,
    b.method,
    b.status,
    b.paid_amount,
    b.currency,
    b.paid_at
  from base b
  left join {{ ref('stg_orders') }} o
    on o.order_id = b.order_ref
),
fx as (
  select rate_date, currency, rate_to_brl
  from {{ ref('stg_fx_rates') }}
)
select
  j.payment_id,
  j.order_id,
  j.method,
  j.status,
  j.paid_amount,
  j.currency,
  (j.paid_amount * coalesce(f.rate_to_brl, 1))::numeric as paid_amount_brl,
  j.paid_at
from joined j
left join fx f
  on f.rate_date = date(j.paid_at) and f.currency = j.currency