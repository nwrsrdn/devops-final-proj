#!/bin/sh

helm delete aws-load-balancer-controller -n kube-system
kubectl delete ingress app-ingress -n cloud

helm repo add eks https://aws.github.io/eks-charts
helm repo update

helm install aws-load-balancer-controller eks/aws-load-balancer-controller -n kube-system --set clusterName=Erwin_eks_cluster --set serviceAccount.create=false --set serviceAccount.name=aws-load-balancer-controller

sleep 30

kubectl apply -f ./kubernetes/manifests/ingress/app-ingress.yaml

sleep 10

kubectl get ingress -n cloud
