--
-- Maven Auto Database to Liquibase Generator Plugin
-- 2.1.3
--
-- Name: instruments_search

create view instruments_search as  SELECT i.id,
    i.registered_at,
    i.type,
    i.subtype,
    i.status,
    i.source,
    i.custom_data,
    e.id AS entity_id,
    e.registered_at AS entity_registered_at,
    e.type AS entity_type,
    e.subtype AS entity_subtype,
    e.status AS entity_status,
    e.source AS entity_source,
    e.name AS entity_name,
    e.year_of_birth AS entity_year_of_birth,
    e.month_of_birth AS entity_month_of_birth,
    e.day_of_birth AS entity_day_of_birth,
    e.gender AS entity_gender,
    e.custom_data AS entity_custom_data,
    e.national_identification_number AS entity_nin,
    e.birth_date AS entity_birth_date,
    e.pep AS entity_pep,
    e.risk_score AS entity_risk_score
   FROM (instruments i
     LEFT JOIN entities e ON (((e.id)::text = (i.entity_id)::text)));
