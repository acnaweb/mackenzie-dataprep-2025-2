## Domínios e Tabelas (Bronze/Raw)

Fontes:

- App (mobile), Web (site), POS (loja física)
- MKT (campanhas / cliques)
- Geo (tabela de CEP → UF/Região)
- FX (câmbio diário, para normalizar moeda)

Tabelas RAW (seeds/CSV):

- raw_customers (clientes)
- raw_products (produtos)
- raw_orders_app, raw_orders_web, raw_orders_pos (pedidos por canal)
- raw_order_items_* (itens do pedido por canal)
- raw_payments (pagamentos)
- raw_events_web (eventos de navegação web)
- raw_marketing_clicks (cliques de campanha)
- raw_geo_zipcode (enriquecimento geo por CEP)
- raw_fx_rates (câmbio por dia e moeda)

## Camada Silver (stg_) — onde exercitamos Cleansing/Normalization/Filtering/Mapping/Manipulation/Integration/Enrichment

- Principais decisões didáticas

    - Unificar chaves: order_id, customer_id, product_id padronizadas.
    - Normalizar datas para TIMESTAMP/DATE consistentes.
    - Moeda base: converter tudo para BRL usando raw_fx_rates.
    - Enriquecer cliente com raw_geo_zipcode.
    - Remover duplicados e sanear emails/telefones.

## Camada Gold (marts) — Aggregation + Semântica de Negócio

