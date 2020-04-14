# Custome Fluentd Container Image

## Tested Environment

- OpenShift 4.3


## How to deploy

Build Container

```
$ oc new-project custom-fluentd
$ oc new-build fluentd --strategy=docker --binary=true
```

Create service account and add a scc to the account

```
$ oc create sa fluentd
# oc adm policy add-scc-to-user anyiid -z fluentd
```

Deploy fluentd and patch the dc.

```
$ oc new-app fluentd
$ oc patch dc/fluentd -p '{"spec":{"template":{"spec":{"securityContext":{"runAsUser": 0}, "serviceAccountName": "fluentd"}}}}'
```
