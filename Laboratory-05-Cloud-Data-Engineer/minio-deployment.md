## I deployed MinIO using Docker in the KillerCoda Ubuntu Playground. The original MinIO image in the instructions was not accessible in my environment, so I used the `elestio/minio` image that successfully worked in my Docker environment.

The command I used was:

```bash
docker run -d -p 9000:9000 -p 9001:9001 --name minio-server \
-e "MINIO_ROOT_USER=cloudadmin" \
-e "MINIO_ROOT_PASSWORD=CloudNova2026!" \
elestio/minio server /data --console-address ":9001"
```


## I used port `9001` to access the MinIO Web Console.

Port `9000` is used for the MinIO API.


I created a bucket named:

`client-photos`

I used this bucket to store the sample file that I uploaded.



The `-e` options were used to configure the administrator login information.

`MINIO_ROOT_USER=cloudadmin` sets the administrator username.

`MINIO_ROOT_PASSWORD=CloudNova2026!` sets the administrator password.



## I checked the container using:

```bash
docker ps
```

The `minio-server` container was running successfully and ports `9000` and `9001` were mapped.


