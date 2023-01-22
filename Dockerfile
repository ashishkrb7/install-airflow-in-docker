FROM ubuntu
LABEL maintainer="Ashish Kumar <ashishkrb7@gmail.com>"
ENV TZ=Asia/Kolkata DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install tzdata 
RUN apt-get update
RUN apt-get install sudo
RUN apt-get install vim -y
RUN sudo apt-get install python3-pip -y
RUN sudo apt-get install sqlite3 -y
RUN sudo apt-get install python3.10-venv -y
RUN python3 -m venv venv
RUN . venv/bin/activate
RUN sudo apt-get install libpq-dev -y
RUN pip install "apache-airflow[postgres]==2.5.0" --constraint "https://raw.githubusercontent.com/apache/airflow/constraints-2.5.0/constraints-3.7.txt"
RUN airflow db init
RUN sudo apt-get install postgresql postgresql-contrib -f -y
RUN sed -i '/listen_addresses/s/^#//g' /etc/postgresql/14/main/postgresql.conf
RUN sudo service postgresql restart && sudo -H  -u postgres bash -c "psql -c \"CREATE DATABASE airflow;\" -c  \"CREATE USER airflow WITH PASSWORD 'airflow'; GRANT ALL PRIVILEGES ON DATABASE airflow TO airflow;\""  && sed -i 's#sqlite:////root/airflow/airflow.db#postgresql+psycopg2://airflow:airflow@localhost/airflow#g' /root/airflow/airflow.cfg && grep sql_alchemy /root/airflow/airflow.cfg && sed -i 's#SequentialExecutor#LocalExecutor#g' /root/airflow/airflow.cfg && grep executor /root/airflow/airflow.cfg && airflow db init && airflow users create -u airflow -f airflow -l airflow -r Admin -e airflow@gmail.com -p airflow 
# RUN sleep 10000
# RUN sudo service postgresql restart && sudo -i -u postgres && psql -c "CREATE DATABASE airflow; CREATE USER airflow WITH PASSWORD 'airflow'; GRANT ALL PRIVILEGES ON DATABASE airflow TO airflow;"
EXPOSE 8080
COPY setup.sh /setup.sh
RUN chmod 777 /setup.sh
ENTRYPOINT ["/bin/bash", "-c", "/setup.sh"]
