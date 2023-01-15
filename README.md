# How to install Airflow in Docker?

Date: January 14, 2023

> To restart the Postgres

`sudo service postgresql restart`

> To login Postgres

`sudo -i -u postgres`

> To run command on Postgres for giving all the required permission

`psql`

```sql
CREATE DATABASE airflow; CREATE USER airflow WITH PASSWORD 'airflow'; GRANT ALL PRIVILEGES ON DATABASE airflow TO airflow;
```

> To change the database from **sqlite** to **postgresql**

`sed -i 's#sqlite:////root/airflow/airflow.db#postgresql+psycopg2://airflow:airflow@localhost/airflow#g' /root/airflow/airflow.cfg`

> To change the executor from sequential to parallel

`sed -i 's#SequentialExecutor#LocalExecutor#g' /root/airflow/airflow.cfg`

> To check DB

`grep sql_alchemy airflow.cfg`

> To check executor

`grep executor airflow.cfg`

> To initialize the airflow

`airflow db init`

> To create user instance in airflow

`airflow users create -u airflow -f airflow -l airflow -r Admin -e airflow@gmail.com -p airflow`

> To start the airflow webserver (Space after & is important)

`airflow webserver & `

> To initialize the airflow scheduler

`airflow scheduler`
