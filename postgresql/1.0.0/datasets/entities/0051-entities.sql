--
-- Maven Auto Database to Liquibase Generator Plugin
-- 2.1.3
--
-- Table: entities

insert into entities
  (id, registered_at, type, subtype, status, source, name, year_of_birth, month_of_birth, day_of_birth, gender, custom_data, national_identification_number, birth_date, pep, risk_score)
values
  ('ffffa3c3-500f-4db1-a', '2000-10-21 00:00:00', 'company'::t_entity_type, 'platinum', 'active'::t_entity_status, 'internal'::t_resource_context, 'Malissa Priwin HWL Engineering P.C.', 1976, 10, 21, 'not_declared'::t_gender, '{}', '1-9', NULL, false, 0);
