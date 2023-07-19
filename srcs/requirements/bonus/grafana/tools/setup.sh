grafana cli plugins install grafana-piechart-panel

grafana cli --homepath "/usr/share/grafana" admin reset-admin-password $GRAFANA_ADMIN_PASSWORD

sed "s/MYSQL_WORDPRESS_DATABASE/$MYSQL_WORDPRESS_DATABASE/1" -i -r /var/lib/grafana/provisioning/datasources/wp_database_provider.yml
sed "s/MYSQL_USERNAME/$MYSQL_USERNAME/1" -i -r /var/lib/grafana/provisioning/datasources/wp_database_provider.yml
sed "s/MYSQL_PASSWORD/$MYSQL_PASSWORD/1" -i -r /var/lib/grafana/provisioning/datasources/wp_database_provider.yml

grafana server \
    --config /etc/grafana.ini \
    --homepath /usr/share/grafana \
    cfg:paths.data=/var/lib/grafana/data \
    cfg:paths.plugins=/var/lib/grafana/plugins \
    cfg:paths.provisioning=/var/lib/grafana/provisioning \
    cfg:server.http_addr=0.0.0.0 \
    cfg:server.domain=$DOMAIN_NAME \
    cfg:auth.anonymous.enabled=true \
    cfg:security.disable_initial_admin_creation=true \
    cfg:server.root_url=%\(protocol\)s://%\(domain\)s:%\(http_port\)s/grafana/

