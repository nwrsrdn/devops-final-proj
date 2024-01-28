#!/bin/sh

# ./scripts/02-build-k8s.sh <resource>

# Apply changes to configs
if [ $1 == 'config' ]
then
  kubectl apply -f ./kubernetes/manifests/namespaces/cloud_namespace.yaml
  kubectl apply -f ./kubernetes/manifests/configs/config_map.yaml
  kubectl apply -f ./kubernetes/manifests/configs/secrets.yaml
  kubectl apply -f ./kubernetes/manifests/ingress/service-account.yaml
  # echo -n 'postgres' | base64 &&
  # echo 'cG9zdGdyZXM=' | base64 --decode &&
fi

# Apply changes to services
if [ $1 == 'svc' ]
then 
  kubectl apply -f ./kubernetes/manifests/services/postgres_service.yaml
  kubectl apply -f ./kubernetes/manifests/services/redis_service.yaml
  kubectl apply -f ./kubernetes/manifests/services/result_app_service.yaml
  kubectl apply -f ./kubernetes/manifests/services/vote_app_service.yaml
  kubectl apply -f ./kubernetes/manifests/services/proxy_service.yaml
  # kubectl patch svc proxy-server-svc -p '{"spec":{"externalIPs":["10.34.35.131"]}}'
fi

# Apply changes to db & redis
if [ $1 == 'db' ]
then
  kubectl apply -f ./kubernetes/manifests/deployments/postgres_deployment.yaml
  kubectl apply -f ./kubernetes/manifests/deployments/redis_deployment.yaml
fi

# Apply changes to apps
if [ $1 == 'apps' ]
then
  kubectl apply -f ./kubernetes/manifests/deployments/result_app_deployment.yaml
  kubectl apply -f ./kubernetes/manifests/deployments/vote_app_deployment.yaml
  kubectl apply -f ./kubernetes/manifests/deployments/worker_app_deployment.yaml
fi

# Apply changes to extras
if [ $1 == 'extras' ]
then
  kubectl apply -f ./kubernetes/manifests/deployments/proxy_server_deployment.yaml
  kubectl apply -f ./kubernetes/manifests/deployments/seeder_app_deployment.yaml
fi

# Delete all resources
if [ $1 == 'delete-all' ]
then
  kubectl delete namespace cloud
  # kubectl delete configmap voting-app-config-map
  # kubectl delete secret voting-app-secrets
  # kubectl delete service result
  # kubectl delete service vote
  # kubectl delete service db
  # kubectl delete service redis
  # kubectl delete service proxy-server-svc
  # kubectl delete deployment vote-app
  # kubectl delete deployment worker-app
  # kubectl delete deployment proxy-server
  # kubectl delete pod seeder-app
  # kubectl delete deployment redis-db
  # kubectl delete deployment result-app
  # kubectl delete deployment postgres-db
fi

# kubectl scale deployment vote --replicas=2 -n cloud
# kubectl autoscale deployment vote-app --cpu-percent=50 --min=1 --max=2
# kubectl set image deployments/vote-app vote-app=966437228244.dkr.ecr.ap-southeast-1.amazonaws.com/vote:1.0
# kubectl rollout restart deployment aws-load-balancer-controller -n kube-system