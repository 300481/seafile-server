# seafile-server

Helm chart for Seafile Server

# install

```
helm repo add seafile https://300481.github.io/charts/
helm repo update
helm upgrade --install seafile seafile/seafile --version 0.3.0 --values YOUR-VALUES.yaml
```

# upgrade

## from 0.2.5

run `mysql_upgrade -u root -p` inside the mysql container because of upgrade from mariadb:10.1 to mariadb:10.5
