--
-- Maven Auto Database to Liquibase Generator Plugin
-- 2.1.3
--
-- Name: cases_search

create view cases_search as  SELECT id AS case_id,
    title,
    start_date,
    end_date,
    deadline_date,
    pending_date,
    state,
    (tags)::text AS tags,
    assigned_to,
    assigned_at,
    classified_by,
    classified_at,
    created_by,
    created_at
   FROM cases c;
