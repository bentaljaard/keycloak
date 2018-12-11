#!/bin/bash

# Create new project
oc new-project keycloak

# Create a postgresql database
oc new-app -n keycloak \
	--template=postgresql-persistent \
	-p POSTGRESQL_USER=keycloak \
	-p POSTGRESQL_DATABASE=keycloak

# Create keycloak application
oc new-app -n keycloak \
	-p DB_VENDOR=POSTGRES \
	-p NAMESPACE=keycloak \
	-p KEYCLOAK_USER=admin \
	-f keycloak-https.json

# Configure keycloak deployment
oc rollout pause deploymentconfig/keycloak -n keycloak
oc patch deploymentconfig/keycloak -p '{"spec":{"strategy":{"type":"Recreate"}}}' -n keycloak
oc set env deploymentconfig/keycloak -n keycloak DB_DATABASE=keycloak DB_ADDR=postgresql DB_PORT=5432 
oc patch  deploymentconfig/keycloak -p '{"spec":{"template":{"spec":{"containers":[{"name":"keycloak","env":[{"name":"DB_PASSWORD", "valueFrom":{"secretKeyRef":{"key":"database-password","name":"postgresql"}}}]}]}}} }'
oc rollout resume deploymentconfig/keycloak

//TODO modify template to create secret for keycloak admin console