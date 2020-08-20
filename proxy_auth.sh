#!/bin/bash

echo "Starting proxy on port 5432"

cloud_sql_proxy -instances=sbux-datalake:us-central1:master-instance-datalake=tcp:0.0.0.0:5432 -credential_file="${HOME}/.config/gcloud/legacy_credentials/$(gcloud config get-value account | tail -n 1)/adc.json" 


