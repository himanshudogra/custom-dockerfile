#!/bin/sh
OFFLINE_ACCESS_TOKEN="something important here" # token from https://cloud.redhat.com/beta/openshift/token
TOKEN=$(curl \
	--silent \
	--data-urlencode "grant_type=refresh_token" \
	--data-urlencode "client_id=cloud-services" \
	--data-urlencode "refresh_token=${OFFLINE_ACCESS_TOKEN}" \
	https://sso.redhat.com/auth/realms/redhat-external/protocol/openid-connect/token | \
	jq -r .access_token)
ocm login --token=$TOKEN --url https://api.stage.openshift.com
if [ "$1" != "" ]; then
    oc logout 2>/dev/null
    ocm cluster login $1
else
    ocm cluster list --managed
fi
