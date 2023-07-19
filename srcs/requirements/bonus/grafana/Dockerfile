FROM alpine:3.17

EXPOSE 3000
RUN apk add grafana --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community/

RUN mkdir -p /var/lib/grafana/provisioning/dashboards
RUN mkdir -p /var/lib/grafana/provisioning/datasources
RUN mkdir -p /etc/dashboards

COPY conf/wp_dashboard_provider.yml /var/lib/grafana/provisioning/dashboards/
COPY conf/wp_statistics_dashboard.json /etc/dashboards/
COPY conf/wp_database_provider.yml /var/lib/grafana/provisioning/datasources/

COPY tools/setup.sh /usr/local/bin/

ENTRYPOINT ["/bin/sh", "/usr/local/bin/setup.sh"]