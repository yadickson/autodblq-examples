--
-- Maven Auto Database to Liquibase Generator Plugin
-- 2.0.3-SNAPSHOT
--
-- Name: MAE_DEFCARACT

create view MAE_DEFCARACT (CIA_K_EMPRESA, TIP_K_TIPOCARACT, DEF_K_CODCARACT, DEF_C_CODCARACT, DEF_A_DESCARACT) as select
  CIA_K_EMPRESA,
  TIP_K_TIPOCARACT,
 VAL_K_CODCARACT  ,
 VAL_A_DESCARACT  ,
 VAL_C_CODCARACT
from MAE_VALCARAC
