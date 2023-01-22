# How to install Airflow in Docker?

This repository is created for the easy installation of airflow.

### To build docker image use below command

```
docker build -t airflow:2.5.0 .
```

### To run docker container use below command

```
docker rm -f airflow
```

```
docker run -p 5555:8080 -d --name airflow airflow:2.5.0
```

or (If want to use pre=built image)

```
docker run -p 5555:8080 -d --name airflow ashishkrb7/airflow:2.5.0 
```

```
docker exec -it airflow /bin/sh
```

**Open Browser after 2 minutes and use http://localhost:5555 and use airflow as username and airflow as password**


## Docker image

Docker image is available at [https://hub.docker.com/r/ashishkrb7/airflow](https://hub.docker.com/r/ashishkrb7/airflow)
## Acknowledgements

 - [Youtube](https://www.youtube.com/watch?v=o88LNQDH2uI)

## Authors

- [Ashish Kumar](https://www.linkedin.com/in/ashishkrb7/)

## License

[MIT](./LICENSE)
