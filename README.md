# seafile-server

Helm chart for Seafile Server

[![Artifact HUB](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/dr300481)](https://artifacthub.io/packages/search?repo=dr300481)

# install

```
helm repo add seafile https://300481.github.io/charts/
helm repo update
helm upgrade --install seafile seafile/seafile:7.1.5 --values YOUR-VALUES.yaml
```
