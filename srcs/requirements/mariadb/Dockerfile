# base image for docker image
FROM debian:bullseye
#update the package index files, upgrade the actual package files
RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y mariadb-server netcat

COPY ./mdb-conf.sh /mdb-conf.sh

RUN chmod +x /mdb-conf.sh

ENTRYPOINT ["./mdb-conf.sh"]
 