# How to install Airflow in Docker?

Date: January 14, 2023

`sudo service postgresql restart`

`sudo -i -u postgres`

`psql`

    CREATE DATABASE airflow;
    CREATE USER airflow WITH PASSWORD 'airflow';
    GRANT ALL PRIVILEGES ON DATABASE airflow TO airflow;

    sed -i 's#sqlite:////home/ubuntu/airflow/airflow.db#postgresql+psycopg2://airflow:airflow@localhost/airflow#g' airflow.cfg

    sed -i 's#SequentialExecutor#LocalExecutor#g' airflow.cfg

`pip install kubernetes`

`airflow db init`

`airflow users create -u airflow -f airflow -l airflow -r Admin -e airflow@gmail.com -p airflow`
`airflow webserver & `
`airflow scheduler`