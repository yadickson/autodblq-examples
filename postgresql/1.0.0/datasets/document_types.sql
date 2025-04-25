--
-- Maven Auto Database to Liquibase Generator Plugin
-- 2.1.3
--
-- Table: document_types

insert into document_types
  (code, description, system, content_type)
values
  ('7z', '7z', false, 'application/x-7z-compressed'),
  ('doc', 'doc', false, 'application/msword'),
  ('docx', 'docx', false, 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'),
  ('jpeg', 'jpeg', false, 'image/jpeg'),
  ('jpg', 'jpg', false, 'image/jpeg'),
  ('json', 'json', false, 'application/json'),
  ('pdf', 'pdf', false, 'application/pdf'),
  ('png', 'png', false, 'image/png'),
  ('rar', 'rar', false, 'application/vnd.rar'),
  ('svg', 'svg', false, 'image/svg+xml'),
  ('txt', 'txt', false, 'text/plain'),
  ('xls', 'xls', false, 'application/vnd.ms-excel'),
  ('xlsx', 'xlsx', false, 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'),
  ('zip', 'zip', false, 'application/zip');
