-- Fato de cliques de marketing
select
  m.click_id,
  c.customer_id,
  m.channel,
  m.campaign,
  m.clicked_at
from {{ ref('stg_marketing_clicks') }} m
left join {{ ref('dim_customer') }} c
  on lower(c.email) = m.customer_email