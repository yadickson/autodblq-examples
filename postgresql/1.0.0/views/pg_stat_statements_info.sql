--
-- Maven Auto Database to Liquibase Generator Plugin
-- 2.1.3
--
-- Name: pg_stat_statements_info

create view pg_stat_statements_info as  SELECT dealloc,
    stats_reset
   FROM pg_stat_statements_info() pg_stat_statements_info(dealloc, stats_reset);
