# seafile-server

Helm chart for Seafile Server

[![Artifact HUB](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/dr300481)](https://artifacthub.io/packages/search?repo=dr300481)

# install

```
helm repo add seafile https://300481.github.io/charts/
helm repo update
helm upgrade --install seafile seafile/seafile --version 0.4.4 --values YOUR-VALUES.yaml
```

# upgrade

## from 0.3.0 to 0.4.4

nothing to do

## from 0.2.5 to 0.3.0

run `mysql_upgrade -u root -p` inside the mysql container because of upgrade from mariadb:10.1 to mariadb:10.5

# contribution

If you have any ideas, just create a pull request from your fork or open an issue here.

I will try to work on it as soon as possible, but cannot give any guarantee because this is my hobby project.

If you want to get in contact, visit my [site](https://300481.tk) and find me on social medias.
