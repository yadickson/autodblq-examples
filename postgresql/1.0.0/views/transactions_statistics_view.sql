--
-- Maven Auto Database to Liquibase Generator Plugin
-- 2.1.3
--
-- Name: transactions_statistics_view

create view transactions_statistics_view as  WITH base_data AS (
         SELECT combined_transactions.s_entity_id AS entity_id,
            combined_transactions.s_amount,
            combined_transactions.executed_at,
            combined_transactions.r_context,
            combined_transactions.s_context,
            date(combined_transactions.executed_at) AS transaction_date,
            CURRENT_DATE AS today,
            (CURRENT_DATE - '30 days'::interval) AS thirty_days_ago
           FROM combined_transactions
        ), historical_stats AS (
         SELECT base_data.entity_id,
            count(*) AS total_transactions,
            count(DISTINCT date(base_data.executed_at)) AS total_days
           FROM base_data
          GROUP BY base_data.entity_id
        ), moving_month_stats AS (
         SELECT base_data.entity_id,
            count(*) AS total_transactions_moving_month,
            ceil((date_part('day'::text, (max(base_data.executed_at) - min(base_data.executed_at))) / (30.0)::double precision)) AS total_moving_months
           FROM base_data
          GROUP BY base_data.entity_id
        ), monthly_data AS (
         SELECT base_data.entity_id,
            COALESCE(count(*) FILTER (WHERE ((base_data.r_context = 'external'::t_resource_context) AND (base_data.s_context = 'internal'::t_resource_context))), (0)::bigint) AS trx_q_deposit_month,
            COALESCE(avg(base_data.s_amount) FILTER (WHERE ((base_data.r_context = 'external'::t_resource_context) AND (base_data.s_context = 'internal'::t_resource_context))), (0)::numeric) AS trx_mean_deposit_month,
            COALESCE(stddev(base_data.s_amount) FILTER (WHERE ((base_data.r_context = 'external'::t_resource_context) AND (base_data.s_context = 'internal'::t_resource_context))), (0)::numeric) AS trx_std_deposit_month,
            COALESCE(count(*) FILTER (WHERE ((base_data.r_context = 'internal'::t_resource_context) AND (base_data.s_context = 'external'::t_resource_context))), (0)::bigint) AS trx_q_withdrawl_month,
            COALESCE(avg(base_data.s_amount) FILTER (WHERE ((base_data.r_context = 'internal'::t_resource_context) AND (base_data.s_context = 'external'::t_resource_context))), (0)::numeric) AS trx_mean_withdrawl_month,
            COALESCE(stddev(base_data.s_amount) FILTER (WHERE ((base_data.r_context = 'internal'::t_resource_context) AND (base_data.s_context = 'external'::t_resource_context))), (0)::numeric) AS trx_std_withdrawl_month
           FROM base_data
          WHERE ((base_data.executed_at >= base_data.thirty_days_ago) AND (base_data.executed_at < base_data.today))
          GROUP BY base_data.entity_id
        ), daily_data AS (
         SELECT base_data.entity_id,
            COALESCE(count(*) FILTER (WHERE ((base_data.r_context = 'external'::t_resource_context) AND (base_data.s_context = 'internal'::t_resource_context))), (0)::bigint) AS trx_q_deposit_day,
            COALESCE(avg(base_data.s_amount) FILTER (WHERE ((base_data.r_context = 'external'::t_resource_context) AND (base_data.s_context = 'internal'::t_resource_context))), (0)::numeric) AS trx_mean_deposit_day,
            COALESCE(sum(base_data.s_amount) FILTER (WHERE ((base_data.r_context = 'external'::t_resource_context) AND (base_data.s_context = 'internal'::t_resource_context))), (0)::numeric) AS trx_sum_deposit_day,
            COALESCE(count(*) FILTER (WHERE ((base_data.r_context = 'internal'::t_resource_context) AND (base_data.s_context = 'external'::t_resource_context))), (0)::bigint) AS trx_q_withdrawl_day,
            COALESCE(avg(base_data.s_amount) FILTER (WHERE ((base_data.r_context = 'internal'::t_resource_context) AND (base_data.s_context = 'external'::t_resource_context))), (0)::numeric) AS trx_mean_withdrawl_day,
            COALESCE(sum(base_data.s_amount) FILTER (WHERE ((base_data.r_context = 'internal'::t_resource_context) AND (base_data.s_context = 'external'::t_resource_context))), (0)::numeric) AS trx_sum_withdrawl_day
           FROM base_data
          WHERE (base_data.transaction_date = base_data.today)
          GROUP BY base_data.entity_id
        ), summary_data AS (
         SELECT base_data.entity_id,
            COALESCE(count(*) FILTER (WHERE ((base_data.transaction_date >= base_data.thirty_days_ago) AND (base_data.transaction_date < base_data.today))), (0)::bigint) AS q_trx_month,
            COALESCE(count(*) FILTER (WHERE (base_data.transaction_date = CURRENT_DATE)), (0)::bigint) AS q_trx_day,
            COALESCE(sum(base_data.s_amount) FILTER (WHERE (base_data.transaction_date = CURRENT_DATE)), (0)::numeric) AS sum_trx_day
           FROM base_data
          GROUP BY base_data.entity_id, base_data.transaction_date
        )
 SELECT e.id AS entity_id,
    COALESCE(m.trx_q_deposit_month, (0)::bigint) AS trx_q_deposit_month,
    COALESCE(m.trx_mean_deposit_month, (0)::numeric) AS trx_mean_deposit_month,
    COALESCE(m.trx_std_deposit_month, (0)::numeric) AS trx_std_deposit_month,
    COALESCE(m.trx_q_withdrawl_month, (0)::bigint) AS trx_q_withdrawl_month,
    COALESCE(m.trx_mean_withdrawl_month, (0)::numeric) AS trx_mean_withdrawl_month,
    COALESCE(m.trx_std_withdrawl_month, (0)::numeric) AS trx_std_withdrawl_month,
    COALESCE(d.trx_q_deposit_day, (0)::bigint) AS trx_q_deposit_day,
    COALESCE(d.trx_mean_deposit_day, (0)::numeric) AS trx_mean_deposit_day,
    COALESCE(d.trx_sum_deposit_day, (0)::numeric) AS trx_sum_deposit_day,
    COALESCE(d.trx_q_withdrawl_day, (0)::bigint) AS trx_q_withdrawl_day,
    COALESCE(d.trx_mean_withdrawl_day, (0)::numeric) AS trx_mean_withdrawl_day,
    COALESCE(d.trx_sum_withdrawl_day, (0)::numeric) AS trx_sum_withdrawl_day,
    COALESCE(s.q_trx_day, (0)::bigint) AS q_trx_day,
    COALESCE(s.q_trx_month, (0)::bigint) AS q_trx_month,
    COALESCE(s.sum_trx_day, (0)::numeric) AS sum_trx_day,
    COALESCE(
        CASE
            WHEN (h.total_days > 0) THEN ((h.total_transactions)::numeric / (h.total_days)::numeric)
            ELSE (0)::numeric
        END, (0)::numeric) AS mean_trx_day,
    COALESCE(
        CASE
            WHEN (mm.total_moving_months > (0)::double precision) THEN (((mm.total_transactions_moving_month)::numeric)::double precision / mm.total_moving_months)
            ELSE (0)::double precision
        END, (0)::double precision) AS mean_trx_month
   FROM (((((entities e
     LEFT JOIN monthly_data m ON (((e.id)::text = (m.entity_id)::text)))
     LEFT JOIN daily_data d ON (((e.id)::text = (d.entity_id)::text)))
     LEFT JOIN summary_data s ON (((e.id)::text = (s.entity_id)::text)))
     LEFT JOIN historical_stats h ON (((e.id)::text = (h.entity_id)::text)))
     LEFT JOIN moving_month_stats mm ON (((e.id)::text = (mm.entity_id)::text)));
