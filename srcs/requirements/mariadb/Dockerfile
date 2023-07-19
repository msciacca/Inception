FROM alpine:3.17

# Expose the MariaDB Server port
EXPOSE 3306
# Install MariaDB-Server and MariaDB-Client
RUN apk add mysql mysql-client

# Copy the setup file into the Docker image
COPY tools/setup.sh /usr/local/bin/
# Create the folder where the MariaDB Socket will be created
RUN mkdir /run/mysqld

# Set the entrypoint for the Docker image
ENTRYPOINT ["/bin/sh", "/usr/local/bin/setup.sh"]
