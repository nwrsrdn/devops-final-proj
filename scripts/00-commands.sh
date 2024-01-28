#!/bin/sh

# Login to AWS using the newly created IAM Account & Access keys
if [ $1 == 'login' ]
then
  # export AWS_ACCESS_KEY_ID="AKIA6CBBFZ3KMO2UCIUB"
  # export AWS_SECRET_ACCESS_KEY="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"
  # cat ~/.aws/credentials
  # cat ~/.aws/config
  export AWS_ACCESS_KEY_ID="ASIA23UKCIVOWXEBZEMW" && \
  export AWS_SECRET_ACCESS_KEY="PDQiLN6yz7+u/+XSRyRys80mVLAz5vha6cVlWt0n" && \
  export AWS_SESSION_TOKEN="IQoJb3JpZ2luX2VjELf//////////wEaDmFwLXNvdXRoZWFzdC0xIkYwRAIgAhnJRKLoq3V1iwXrHt0x5EqNwrBeZNAnuOOMrzDMHt0CIH9LCDsGipbkTZQteTkF69LiSKoqeds0CoaOSQCOZh6iKpMDCND//////////wEQBBoMNzQ2NTQwMTIzNDg1IgwGfqqPxPOc3abaJ70q5wLXHbxD0dBy5zV9LVIAe6MrnI5w/3ozsy1ZNybbAfbRTod2wExLJ3+9bLYvCc+6yLYuz94EXFnPIOFZN0BVv0z7KtpX1Y/MfeCcT9fBJL8OLs2+kM5UsSzwIbhX/cwvnbJX/trmHc5us73Zsj5OZeT+uZ+NvzmWJkuSQoFuIvFr2aD4GcTLUyVTcwvokDJrDjNGXB8cuFVNXq1w9PAGfEiDagT8Q84l2wfwt2URR+4yR1nLsWsZPVPDr/Ey29WK82aUf1zOJthOwKHP429TCiDccNaBn0mjYbcWv9mlcnwji8umNmuDo1wOBfbpyJz6jrk+90k0HLjn6qy4lkHEvlvKTWFjh7UuHLUfK7NcLnTF+VQRxnInsk1XdH3waABhODLC9her+2/Ljfe8M7d3Zh3mydYKdA98VtFQ3N+NZxoJlCVf/sBcmgdXEtgXON6eJOv1ggIwCjUrvAv3xcClaD0j7IYBQWajAzDXwsipBjqnAXQLbqxyA1D7BtZ8MSqREAPD106f5uMLdBWwE11lekTUbE9Si0PvARI+134AsPi6CPNicHdEZT1/YCLKI0+KmS682lzaUxV3Ic6K3dSvFmZb5/+mjF7dP3m7O5SDu7VOBiZ4Ca2V6s0YfeWiXOF3jhpT+hEFUKYVmgrx6KtefOjgzUlDS987lke+QuQDE1aume/JgrRid3sQJ3v6cr1DkhFw/2ajAGeJ" && \
  aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID && \
  aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY && \
  aws configure set aws_session_token $AWS_SESSION_TOKEN
fi

# Must build the resources first using terraform before executing below commands

# Docker login to ECR
if [ $1 == 'ecr' ]
then
  aws ecr get-login-password --region ap-southeast-1 | docker login --username AWS --password-stdin 746540123485.dkr.ecr.ap-southeast-1.amazonaws.com
fi

# Kubernetes login to EKS cluster
if [ $1 == 'eks' ]
then
  # To connect to AWS EKS cluster
  aws eks update-kubeconfig --name Erwin_eks_cluster --alias Erwin_eks_cluster --user-alias AWS
  
  kubectl create namespace cloud

  # So that EKS can pull images from ECR
  kubectl create secret docker-registry ecr-credentials \
    --docker-server=966437228244.dkr.ecr.ap-southeast-1.amazonaws.com \
    --docker-username=AWS \
    --docker-password="$(aws ecr get-login-password --region ap-southeast-1)" \
    --namespace=cloud

  kubectl config set-context --current --namespace=cloud
fi

if [ $1 == 'clear' ]
then
  docker system prune -af
  kubectl config delete-context arn:aws:eks:ap-southeast-1:966437228244:cluster/Erwin_eks_cluster
  kubectl delete namespace cloud
fi

# cat /etc/hosts