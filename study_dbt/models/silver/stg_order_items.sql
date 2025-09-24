-- Normalização e unificação de itens de pedidos
with app as (
  select
    order_id,
    product as product_id,
    qty::int as quantity,
    unit_price::numeric as unit_price
  from {{ ref('raw_order_items_app') }}
),
web as (
  select
    order_code as order_id,
    product_id,
    quantity::int as quantity,
    price::numeric as unit_price
  from {{ ref('raw_order_items_web') }}
),
pos_raw as (
  select
    pos_order_id as order_id,
    sku,
    quantity::int as quantity,
    price::numeric as unit_price
  from {{ ref('raw_order_items_pos') }}
),
pos as (
  select
    r.order_id,
    sp.product_id,
    r.quantity,
    r.unit_price
  from pos_raw r
  left join {{ ref('stg_products') }} sp
    on sp.sku = r.sku
),
all_items as (
  select order_id, product_id, quantity, unit_price from app
  union all
  select order_id, product_id, quantity, unit_price from web
  union all
  select order_id, product_id, quantity, unit_price from pos
)
select * from all_items