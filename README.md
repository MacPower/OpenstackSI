# OpenStack All-in-One GCP Terraform

## Requirements

* Terraform on your computer
* GCP CLI
* GPC Account

## Building & Running

### First Step: Clone the repo

````bash
git clone https://github.com/luquf/OpenstackSI.git

cd OpenstackSI/
````

### Second Step: Configure GCP 

Create a Google Cloud Platform project

A default project is often set up by default for brand new accounts, but you will start by creating a brand new project to keep this separate and easy to tear down later. After creating it be sure to copy down the project id as it is usually different then the project name
Getting project credentials
Next, set up a service account key which Terraform will use to create and manage resources in your Google Cloud Platform project. Go to the create service account key page. Select the default service account or create a new one, select JSON as the key type and hit Create.

This downloads a JSON file with all the credentials that will be needed for Terraform to manage the resources. This file should be located in a secure place for production projects, but for this example move the downloaded JSON file to the project directory.

You can use the provided gcp-setup.sh to configure gcp with your project on mac 

### Third Step: Setting up Terraform

Modify the variable.tf file for the Terraform config with the right CREDENTIALS_FILE downloaded before, project and region

```yaml
variable "gcp_config_cred_path" {
    type = "string"
    default = "CREDENTIALS_FILE.json"
}

```

Set the project id from the first step to the project property and point the credentials section to the file that was downloaded in the last step. The provider “google” line indicates that you are using the Google Cloud Terraform provider and at this point you can run terraform init to download the latest version o the provider and build the .terraform directory.

Execute the following

```bash
cd terraform-project/

terraform init
```

### Fourth Step: Generate SSH Keypair

````bash
cd OpenstackSI/terraform-project/ssh
ssh-keygen -t rsa
````

Copy the ssh public key to your GCP project. With that you can connect to you instance via SSH and so terraform. 

## Usage

````bash
terraform plan
terraform apply 

#if you want to destroy what you deployed

terraform destroy
````

### Check execution 

Connect to your instance using ssh and tail the log file 

````bash
ssh root@outputed_address

sudo tail -f /var/log/syslog

````

## Connect to Horizon UI

After waiting about 1h30 go to the outputed ip address of the terraform template.

### Connect to your instance

Connect via ssh to your instance and run 

````bash

ssh root@outputed_address
/tmp/get_admin_password.sh
````

This will output the administator password for you to connect to Horizon WebUi