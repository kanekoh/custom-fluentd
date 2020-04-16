# Custome Fluentd Container Image

## Tested Environment

- OpenShift 4.3


## How to deploy

Build Container

```
$ oc new-project custom-fluentd
$ oc new-build --name fluentd --strategy=docker --binary=true
$ oc start-build fluentd --from-dir=.
```

Create service account and add a scc to the account

```
$ oc create sa fluentd
$ oc adm policy add-scc-to-user anyuid -z fluentd
```

Deploy fluentd and patch the dc.

```
$ oc new-app fluentd
$ oc patch dc/fluentd -p '{"spec":{"template":{"spec":{"securityContext":{"runAsUser": 0}, "serviceAccountName": "fluentd"}}}}'
```
