#!/bin/sh

# ./scripts/03-terraform.sh <action>

# Terraform plan
if [ $1 == 'plan' ]
then
  cd ./terraform
  terraform init -migrate-state
  terraform validate
  terraform fmt
  terraform plan -out=terraform.tfplan
fi

# Terraform apply auto-approve
if [ $1 == 'apply' ]
then
  cd ./terraform
  terraform apply "terraform.tfplan"

  # oidc_thumbprint=${echo -t | openssl s_client -showcerts -connect oidc.eks.ap-southeast-1.amazonaws.com:443 2>/dev/null | sed '1,/Starfield Class 2 Certification Authority/d' | sed '/Server certificate/,$d' | sed '$ s/...$//' | openssl x509 -in root_certificate.pem -fingerprint -sha1 -noout | sed 's/://g' | tr '[:upper:]' '[:lower:]' | sed 's/sha1 fingerprint=//'}
  # aws iam update-open-id-connect-provider-thumbprint --open-id-connect-provider-arn "arn:aws:iam::966437228244:oidc-provider/oidc.eks.ap-southeast-1.amazonaws.com/id/5CC2BE9435BBDBE10A4C1E4635724A59" --thumbprint-list $oidc_thumbprint
fi

# Terraform destroy auto-approve
if [ $1 == 'destroy' ]
then
  cd ./terraform
  terraform destroy -auto-approve
fi