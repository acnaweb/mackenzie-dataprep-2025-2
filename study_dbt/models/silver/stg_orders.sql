-- Unificação de pedidos (app, web, pos) com normalização e conversão
with app as (
  select
    order_id,
    cust_id as customer_id,
    order_ts,
    total_amount::numeric as amount,
    upper(currency) as currency,
    'app' as channel
  from {{ ref('raw_orders_app') }}
),
web as (
  select
    order_code as order_id,
    customer_id,
    order_datetime::timestamp as order_ts,
    gross_amount::numeric as amount,
    upper(currency) as currency,
    'web' as channel
  from {{ ref('raw_orders_web') }}
),
pos as (
  select
    pos_order_id as order_id,
    loyalty_customer as customer_id,
    order_date::timestamp as order_ts,
    amount::numeric as amount,
    upper(currency) as currency,
    'pos' as channel
  from {{ ref('raw_orders_pos') }}
),
unioned as (
  select * from app
  union all
  select * from web
  union all
  select * from pos
),
fx as (
  select rate_date, currency, rate_to_brl
  from {{ ref('stg_fx_rates') }}
),
with_fx as (
  select
    u.order_id,
    u.customer_id,
    u.order_ts,
    u.channel,
    u.amount,
    u.currency,
    (u.amount * coalesce(f.rate_to_brl, 1))::numeric as amount_brl
  from unioned u
  left join fx f
    on f.rate_date = date(u.order_ts) and f.currency = u.currency
)
select *
from with_fx
where amount_brl > 0