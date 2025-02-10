# autodblq-examples by oracle
Examples to get liquibase structure from oracle database

## From local or remote

-Premote
-Plocal

## 

```bash
mvn autodblq:generator
```

# To Local
Example to create the basic tables on oracle

**Update:**

```bash
mvn liquibase:update
```

```bash
mvn liquibase:updateSQL
```

**Rollback**

```bash
mvn liquibase:rollback -Dliquibase.rollbackTag=1.0.0-00.0001
```

```bash
mvn liquibase:rollbackSQL -Dliquibase.rollbackTag=1.0.0-00.0001
```
