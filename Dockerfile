FROM mysql/mysql-server:latest as builder

# That file does the DB initialization but also runs mysql daemon, by removing the last line it will only init
RUN ["sed", "-i", "s/exec \"$@\"/echo \"not running $@\"/", "/entrypoint.sh"]

# needed for intialization
ENV MYSQL_ROOT_PASSWORD=root
ENV MYSQL_USER=root
ENV MYSQL_PASSWORD=root

# add only file inside the corresponding directory (excluded the directory itself)
ADD init_folder /docker-entrypoint-initdb.d/

# Need to change the datadir to something else that /var/lib/mysql because the parent docker file defines it as a volume.
# https://docs.docker.com/engine/reference/builder/#volume :
#       Changing the volume from within the Dockerfile: If any build steps change the data within the volume after
#       it has been declared, those changes will be discarded.
RUN ["/entrypoint.sh", "mysqld", "--datadir", "/initialized-db"]

FROM mysql/mysql-server:latest

COPY --from=builder /initialized-db /var/lib/mysql