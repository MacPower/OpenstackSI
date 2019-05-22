#!/bin/bash

PROJECT=""

gcloud projects add-iam-policy-binding $PROJECT \
    --member serviceAccount:$PROJECT-sa@$PROJEC.iam.gserviceaccount.com \
    --role roles/compute.instanceAdmin.v1
gcloud projects add-iam-policy-binding $PROJECT\
    --member serviceAccount:$PROJECT-sa@$PROJECT.iam.gserviceaccount.com \
    --role roles/compute.securityAdmin

gcloud projects get-iam-policy $PROJECT

gcloud iam service-accounts keys create $PROJECT-sa.json \
    --iam-account=$PROJECT-sa@$PROJECT.iam.gserviceaccount.com