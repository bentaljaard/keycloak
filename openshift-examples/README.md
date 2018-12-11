# Keycloak OpenShift examples

This directory contains a set of predefined OpenShift templates for running Keycloak, including:

* `keycloak-https.json` - A standard template for most of the use cases. It uses both HTTP and HTTPS routes.
* `keycloak-https-mutual-tls.json` - A similar template to the one above but uses OpenShift generated certificates to setup Mutual TLS.



## Create new keycloak server with postgresql database

The following script creates a new project for keycloak and deploys a keycloak server with a postgresql database backend.

* `deploy_keycloak.sh' - This script creates a new project called "keycloak" and deploys a keycloak instance with a persistent database
