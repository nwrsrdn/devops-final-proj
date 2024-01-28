#!/bin/sh

kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

sleep 30

kubectl autoscale deployment vote-app --cpu-percent=80 --min=1 --max=5
kubectl autoscale deployment result-app --cpu-percent=80 --min=1 --max=5

sleep 10

kubectl delete -f ./kubernetes/manifests/deployments/seeder_app_deployment.yaml
kubectl apply -f ./kubernetes/manifests/deployments/seeder_app_deployment.yaml