# How to install Airflow in Docker?

This repository is created for the easy installation of airflow.

Date: January 15, 2023
### To build docker image use below command

```
docker build -t airflow:2.5.0 .
```

### To run docker container use below command

```
docker rm -f airflow
```

```
docker run -p 5555:8080 -itd --name airflow airflow:2.5.0
```

```
docker exec -it airflow /bin/sh
```

### Run all the command in sequence

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

### Sample Screen will look like below

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

### Sample Screen will look like below

```sh
(venv) # airflow webserver &
(venv) #   ____________       _____________
 ____    |__( )_________  __/__  /________      __
____  /| |_  /__  ___/_  /_ __  /_  __ \_ | /| / /
___  ___ |  / _  /   _  __/ _  / / /_/ /_ |/ |/ /
 _/_/  |_/_/  /_/    /_/    /_/  \____/____/|__/
Running the Gunicorn Server with:
Workers: 4 sync
Host: 0.0.0.0:8080
Timeout: 120
Logfiles: - -
Access Logformat:
=================================================================
[2023-01-15 20:19:00 +0530] [87] [INFO] Starting gunicorn 20.1.0
[2023-01-15 20:19:00 +0530] [87] [INFO] Listening at: http://0.0.0.0:8080 (87)
[2023-01-15 20:19:00 +0530] [87] [INFO] Using worker: sync
[2023-01-15 20:19:00 +0530] [89] [INFO] Booting worker with pid: 89
[2023-01-15 20:19:00 +0530] [90] [INFO] Booting worker with pid: 90
[2023-01-15 20:19:00 +0530] [91] [INFO] Booting worker with pid: 91
[2023-01-15 20:19:00 +0530] [92] [INFO] Booting worker with pid: 92

(venv) # airflow scheduler
  ____________       _____________
 ____    |__( )_________  __/__  /________      __
____  /| |_  /__  ___/_  /_ __  /_  __ \_ | /| / /
___  ___ |  / _  /   _  __/ _  / / /_/ /_ |/ |/ /
 _/_/  |_/_/  /_/    /_/    /_/  \____/____/|__/
[2023-01-15 20:19:18 +0530] [96] [INFO] Starting gunicorn 20.1.0
[2023-01-15 20:19:18,577] {scheduler_job.py:714} INFO - Starting the scheduler
[2023-01-15 20:19:18,577] {scheduler_job.py:719} INFO - Processing each file at most -1 times
[2023-01-15 20:19:18 +0530] [96] [INFO] Listening at: http://[::]:8793 (96)
[2023-01-15 20:19:18 +0530] [96] [INFO] Using worker: sync
[2023-01-15 20:19:18 +0530] [97] [INFO] Booting worker with pid: 97
[2023-01-15 20:19:18,600] {executor_loader.py:107} INFO - Loaded executor: LocalExecutor
[2023-01-15 20:19:18 +0530] [136] [INFO] Booting worker with pid: 136
[2023-01-15 20:19:18,844] {manager.py:163} INFO - Launched DagFileProcessorManager with pid: 234
[2023-01-15 20:19:18,847] {scheduler_job.py:1399} INFO - Resetting orphaned tasks for active dag runs
[2023-01-15 20:19:18,855] {settings.py:58} INFO - Configured default timezone Timezone('UTC')
```

**Open Browser and use `http://localhost:5555` and use `airflow` as username and `airflow` as password**

## Acknowledgements

 - [Youtube](https://www.youtube.com/watch?v=o88LNQDH2uI)

## Authors

- [Ashish Kumar](https://www.linkedin.com/in/ashishkrb7/)


## License

[MIT](https://choosealicense.com/licenses/mit/)
