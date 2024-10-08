# seafile-server

Helm chart for Seafile Server

# on my own behalf

For me it is just a "hobby project". But I've seen that my own built docker images

for Seafile Version 6, 7 and 8 were pulled more than 4,5k times.

I've contributed a small but essential change to Seafile-Docker to make it usable in Kubernetes.

This change is included from Version 9 of Seafile.

I assume, my Helm Chart is used by many people and from now I plan to use the official images of Haiwen in my Helm Chart.

All the work on the Helm Chart is done in my free time. So it is not perfect.

There are many things to do (e.g. Resource Requests and maybe Limits, Readiness Probes, Container Permissions ...).

If you like this Chart, I would be happy to get a small appreciation maybe by a direct message

with "Thank you" on [LinkedIn](https://www.linkedin.com/in/dennis-riemenschneider/).

If you would like to improve the Chart don't hesitate and create a Pull Request on GitHub.

I'll do my best to check and merge your contributions.

# install

## prerequisites

* Install a MariaDB instance
* Create a secret containing the database root password in the same namespace as Seafile
* Set Values for ```seafile.database.rootPasswordSecret``` and ```seafile.database.hostname```

## installation command
```
helm repo add seafile https://300481.github.io/charts/
helm repo update
helm upgrade --install seafile seafile/seafile --version 0.12.1 --values YOUR-VALUES.yaml
```

# upgrade

## from 0.12.0 to 0.12.1

Update Seafile to 11.0.12

Backward compatible.

## from 0.11.3 to 0.12.0

Add optional nodeSelector and helm policy to keep PVC on uninstall.

Backward compatible.

## from 0.11.2 to 0.11.3

Only updated the README.md

## from 0.11.1 to 0.11.2

Update to Seafile 11.0.3

Backward compatible.

## from 0.11.0 to 0.11.1

Update to Seafile 11.0.2

Backward compatible.

## from 0.10.0 to 0.11.0

Update to Seafile 11.0.1

Backward compatible.

## from 0.9.8 to 0.10.0

Update to Seafile 10.0.1

Backward compatible.

Add variable ```FORCE_HTTPS_IN_CONF=true``` for StatefulSet

Please see [Documentation](https://manual.seafile.com/docker/deploy_seafile_with_docker/#lets-encrypt-ssl-certificate)

This is needed when using an additional reverse proxy and providing your own certificates e.g. with Cert-Manager.

## from 0.9.7 to 0.9.8

Just an update to Seafile 9.0.10

Backward compatible.

## from 0.9.6 to 0.9.7

Just an update to Seafile 9.0.9

Backward compatible.

## from 0.9.5 to 0.9.6

Just an update to Seafile 9.0.8

Backward compatible.

## from 0.9.4 to 0.9.5

Just an update to Seafile 9.0.7

Backward compatible.

## from 0.9.3 to 0.9.4

Just an update to Seafile 9.0.6

Backward compatible.

## from 0.9.2 to 0.9.3

Just an update to Seafile 9.0.5

Backward compatible.

## from 0.9.1 to 0.9.2

Just an update to Seafile 9.0.4

Backward compatible.

## from 0.9.0 to 0.9.1

Just an update to Seafile 9.0.3

Backward compatible.

## from 0.8.0 to 0.9.0

Just an update to Seafile 9.0.2

Backward compatible.

## from 0.7.3 to 0.8.0

This CAN be a breaking change.

The dependencies are removed and some cosmetic cleanups are done.

You now need to provide a MariaDB and Memcached by yourself, it is not installed by the Chart anymore.

## from 0.7.2 to 0.7.3

Just a fresh rebuild of the Docker-Image

## from 0.7.1 to 0.7.2

Patch version for the existingClaim option.

Use instead of 0.7.1

## from 0.7.0 to 0.7.1

Backward compatible change.

Add option ```seafile.persistence.existingClaim``` to be able to use existing Persistent Volumes for Seafile data.

## from 0.6.4 to 0.7.0

This is a breaking change!

The *extraVolumes* and *extraVolumeMounts* are removed and not available anymore.

## from 0.6.3 to 0.6.4

Make dependency MariaDB optional with enable-switch.

By default enabled and backward compatible.

## from 0.6.2 to 0.6.3

Add section *database* in Seafile values.

You now **must** set the database hostname and the secret-details with the root-password

```yaml
seafile:
  database:
    hostname: {}
    rootPasswordSecret:
      name: {}
      key: {}
```

## from 0.6.1 to 0.6.2

Just a fix to the prior version:

```seafile.storageClassName``` to ```seafile.persistence.storageClassName```

## from 0.6.0 to 0.6.1

Add ```seafile.storageClassName``` to be able to set the Storage Class Name of the Seafile Persistent Volume.

If left empty, it will further use the default one.

## from 0.5.3 to 0.6.0

Version 0.6.0 is just a copy of 0.5.3, so there is 100% backward compatibility.

The goal of 0.6.z is to explant the hard dependencies of MariaDB and Memcached subcharts.

I want to deploy both by operators in the future to ensure better availability and upgrade options.

In 0.7.z I plan to upgrade Seafile itself to the newer versions.

## from 0.5.2 to 0.5.3

This update is backward compatible.

Change is the new built seafile-docker image.

## from 0.5.1 to 0.5.2

This update is backward compatible.

New values for `memcached`.

The subchart can be disabled and it is possible to set a FQDN for an external running memcached,

if it is not running in the same namespace with the default service name of `memcached`.

## from 0.5.0 to 0.5.1

This update is backward compatible.

New value `pause: false`. If set to `true` the Seafile StatefulSet replica will be set to 0.

This is a preparation for the following changes.

The following changes will be the removal of the subcharts *mariadb* and *memcached*.

It's planned to manage them in by their own charts.

## from 0.4.4 to 0.5.0

There are major changes:

* Seafile changes from Deployment to StatefulSet with dynamic provisioned volume
* MariaDB is deployed with a Sub Helm Chart (Bitnami)
* Memcached is deployed with a Sub Helm Chart (Bitnami)

The trick is now to get the state from your deployment volumes into the new dynamic provisioned.

You can achieve this by mounting the previous volumes with extraVolumes and extraVolumeMounts in the values.yaml

for the Seafile StatefulSet and for the MariaDB Statefulset.

Additionally you must replace the container images by an image of your choice.

For MariaDB you must deactivate the livenessProbe and readinessProbe.

Then copy/move the state from the previous volumes to the new dynamic provisioned ones.

After moving the state, reset the values (container images, volume mounts, probes etc.)

and restart your application. Cross the fingers!

Don't forget to set `mariadb.auth.rootPassword` to your already existing password. Otherwise the MariaDB container will not start.

And, never ever do this directly on production!

Play with it on a test system first, monday to thursday, not friday 3pm ;-)

## from 0.3.0 to 0.4.4

nothing to do

## from 0.2.5 to 0.3.0

run `mysql_upgrade -u root -p` inside the mysql container because of upgrade from mariadb:10.1 to mariadb:10.5

# Data export / import

Here are some code snippets to handle Database data export / import, related to Seafile.

## connect to database

```bash
export ROOT_PASSWORD=mysecretpassword
mysql -uroot -p${ROOT_PASSWORD} -h mariadb.seafile.svc.cluster.local
```

## create databases

```sql
create database `ccnet_db` character set = 'utf8';
create database `seafile_db` character set = 'utf8';
create database `seahub_db` character set = 'utf8';

create user 'seafile'@'%' identified by 'mysecretseafilepassword';

GRANT ALL PRIVILEGES ON `ccnet_db`.* to `seafile`@`%`;
GRANT ALL PRIVILEGES ON `seafile_db`.* to `seafile`@`%`;
GRANT ALL PRIVILEGES ON `seahub_db`.* to `seafile`@`%`;
```

## export databases

```bash
export ROOT_PASSWORD=mysecretpassword

for database in ccnet seafile seahub; do
  mysqldump -uroot -p${ROOT_PASSWORD} -h mariadb.seafile.svc.cluster.local ${database}_db > ${database}_db.sql
done
```

## import databases

```bash
export ROOT_PASSWORD=mysecretpassword

for database in ccnet seafile seahub; do
  mysql -uroot -p${ROOT_PASSWORD} -h mariadb.seafile.svc.cluster.local ${database}_db < ${database}_db.sql
done
```