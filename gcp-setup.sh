gcloud projects add-iam-policy-binding juju-openstack-isep \
    --member serviceAccount:juju-openstack-isep-sa@juju-openstack-isep.iam.gserviceaccount.com \
    --role roles/compute.instanceAdmin.v1
gcloud projects add-iam-policy-binding juju-openstack-isep \
    --member serviceAccount:juju-openstack-isep-sa@juju-openstack-isep.iam.gserviceaccount.com \
    --role roles/compute.securityAdmin

gcloud projects get-iam-policy juju-openstack-isep

gcloud iam service-accounts keys create juju-openstack-isep-sa.json \
    --iam-account=juju-openstack-isep-sa@juju-openstack-isep.iam.gserviceaccount.com