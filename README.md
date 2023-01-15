# How to install Airflow in Docker?

Date: January 14, 2023

## To build docker image use below command

```docker
docker build -t airflow:2.5.0 .
```

## To run docker container use below command

```docker
docker rm -f airflow

```docker
docker run -p 5555:8080 -itd --name airflow airflow:2.5.0
```

```docker
docker exec -it airflow /bin/sh
```

## Run all the command in sequence

> Start virtual environment

```sh
. /venv/bin/activate
```

> To restart the Postgres

```sh
sudo service postgresql restart
```

> To login Postgres

```sh
sudo -i -u postgres
```

> To run command on Postgres for giving all the required permission

```sh
psql
```

```sql
CREATE DATABASE airflow; CREATE USER airflow WITH PASSWORD 'airflow'; GRANT ALL PRIVILEGES ON DATABASE airflow TO airflow;
```

*Press ctrc+d two times to come put of postgres*

> To change the database from **sqlite** to **postgresql**

```sh
sed -i 's#sqlite:////root/airflow/airflow.db#postgresql+psycopg2://airflow:airflow@localhost/airflow#g' /root/airflow/airflow.cfg
```

> To check DB

```sh
grep sql_alchemy /root/airflow/airflow.cfg
```

> To change the executor from sequential to parallel

```sh
sed -i 's#SequentialExecutor#LocalExecutor#g' /root/airflow/airflow.cfg
```

> To check executor

```sh
grep executor /root/airflow/airflow.cfg
```

> To initialize the airflow

```sh
airflow db init
```

## Sample Screen will look like below

```sh
# . /venv/bin/activate
(venv) # sudo service postgresql restart
 * Restarting PostgreSQL 14 database server                                                    [ OK ]
(venv) # sudo -i -u postgres
postgres@2c188cf1bab8:~$ psql
psql (14.6 (Ubuntu 14.6-0ubuntu0.22.04.1))
Type "help" for help.

postgres=# CREATE DATABASE airflow; CREATE USER airflow WITH PASSWORD 'airflow'; GRANT ALL PRIVILEGES ON DATABASE airflow TO airflow;
CREATE DATABASE
CREATE ROLE
GRANT
postgres=#
\q
postgres@2c188cf1bab8:~$
logout
(venv) # sed -i 's#sqlite:////root/airflow/airflow.db#postgresql+psycopg2://airflow:airflow@localhost/airflow#g' /root/airflow/airflow.cfg
(venv) # grep sql_alchemy /root/airflow/airflow.cfg
sql_alchemy_conn = postgresql+psycopg2://airflow:airflow@localhost/airflow
# Example: sql_alchemy_engine_args = {"arg1": True}
# sql_alchemy_engine_args =
sql_alchemy_pool_enabled = True
sql_alchemy_pool_size = 5
sql_alchemy_max_overflow = 10
sql_alchemy_pool_recycle = 1800
sql_alchemy_pool_pre_ping = True
sql_alchemy_schema =
# sql_alchemy_connect_args =
# When not specified, sql_alchemy_conn with a db+ scheme prefix will be used
(venv) # sed -i 's#SequentialExecutor#LocalExecutor#g' /root/airflow/airflow.cfg
(venv) # grep executor /root/airflow/airflow.cfg
# The executor class that airflow should use. Choices include
# full import path to the class when using a custom executor.
executor = LocalExecutor
# start date from stealing all the executor slots in a cluster.
# Collation for ``dag_id``, ``task_id``, ``key``, ``external_executor_id`` columns
# start with the elements of the list (e.g: "scheduler,executor,dagrun")
[local_kubernetes_executor]
[celery_kubernetes_executor]
celery_app_name = airflow.executors.celery_executor
# The number of seconds to wait before timing out ``send_task_to_executor`` or
[kubernetes_executor]
(venv) # airflow db init
DB: postgresql+psycopg2://airflow:***@localhost/airflow
[2023-01-15 19:14:34,819] {migration.py:204} INFO - Context impl PostgresqlImpl.
[2023-01-15 19:14:34,820] {migration.py:207} INFO - Will assume transactional DDL.
INFO  [alembic.runtime.migration] Context impl PostgresqlImpl.
INFO  [alembic.runtime.migration] Will assume transactional DDL.
INFO  [alembic.runtime.migration] Running stamp_revision  -> 290244fb8b83
WARNI [airflow.models.crypto] empty cryptography key - values will not be stored encrypted.
Initialization done
```

> To create user instance in airflow

```sh
airflow users create -u airflow -f airflow -l airflow -r Admin -e airflow@gmail.com -p airflow
```

Below message will come at the end of couple of execution

*User "airflow" created with role "Admin"*

> To start the airflow webserver (Space after & is important)

```sh
airflow webserver & 
```

> To initialize the airflow scheduler

```sh
airflow scheduler
```
