--
-- Maven Auto Database to Liquibase Generator Plugin
-- 2.1.3
--
-- Table: models

insert into models
  (code, category, created_at, created_by, enabled, updated_at, updated_by)
values
  ('DORMANT', 'ANOMALY_DETECTION'::t_model_category, '2024-05-27 15:31:03.49615', 'me', true, '2024-05-29 11:16:05.075389', 'me'),
  ('DYNAMIC', 'CUSTOM'::t_model_category, '2025-04-04 18:19:40.273041', 'me', true, '2025-04-04 18:19:40.273041', 'me'),
  ('NEWLY_SEEN', 'ANOMALY_DETECTION'::t_model_category, '2024-05-27 15:31:03.49615', 'me', true, '2024-05-29 11:16:05.075389', 'me'),
  ('PASS_THROUGH', 'STRUCTURING'::t_model_category, '2024-05-27 22:35:59.571934', 'me', true, '2024-05-29 11:16:05.075389', 'me');
