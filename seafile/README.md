# seafile-server

Helm chart for Seafile Server

# install

```
helm repo add seafile https://300481.github.io/charts/
helm repo update
helm upgrade --install seafile seafile/seafile --version 0.6.4 --values YOUR-VALUES.yaml
```

# upgrade

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
