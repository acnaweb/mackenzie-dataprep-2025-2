-- Dimensão de produtos
select *
from {{ ref('stg_products') }}