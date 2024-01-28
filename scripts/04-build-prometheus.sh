#!/bin/sh

helm delete prometheus -n cloud
kubectl delete svc grafana-ui -n cloud

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add stable https://charts.helm.sh/stable
helm repo update
helm install prometheus prometheus-community/kube-prometheus-stack -n cloud

sleep 5

kubectl apply -f ./kubernetes/manifests/services/prometheus_service.yaml

sleep 30
kubectl --namespace cloud get pods -l "release=prometheus"
kubectl get svc grafana-ui -n cloud