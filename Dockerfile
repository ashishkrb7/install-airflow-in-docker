FROM ubuntu
ENV TZ=Asia/Kolkata DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install tzdata
RUN apt-get update
RUN apt-get install sudo
RUN apt-get install vim -y
RUN sudo apt-get install python3-pip -y
RUN sudo apt-get install sqlite3 -y
RUN sudo apt-get install python3.10-venv -y
RUN sudo apt-get install libpq-dev -y
RUN pip install "apache-airflow[postgres]==2.5.0" --constraint "https://raw.githubusercontent.com/apache/airflow/constraints-2.5.0/constraints-3.7.txt"
RUN airflow db init
RUN sudo apt-get install postgresql postgresql-contrib -f -y
ADD postgresql /etc/postgresql/
# RUN sudo service postgresql restart
EXPOSE 8080
