# Let's Vote! Application

## Summary

Introducing our latest and exciting project for all Stratizens: The Voting Application! 🗳️💻 This remarkable app aims to empower each and every one of you to have a voice in deciding which cloud service provider will be the ultimate ruler among them all. 👑💻☁️ Your votes will shape the future of our cloud universe, and together, we'll make an informed and collective decision. Join us in this important endeavor to democratize the cloud and make a significant impact! 🌟🌌 Let's embrace this opportunity to exercise our right to choose and create a better cloud experience for everyone. Together, we can elevate the power of decision-making and bring positive change! 🤝🌈 #StratizenVotingApp #EmpoweringChoice #RuleTheClouds #StratizenCloudWars #VotingAppMadness


## Local Setup

1. Clone the project.
```
git clone https://gitlab.stratpoint.cloud/stratpoint-cloud-native/learner-repositories/erwin-andres/final_project.git final-proj
```

2. Go to the root directory of the project and change file permission for the `scripts` folder.
```
cd ./final-proj
chmod -R +x ./scripts
```

3. Make sure you have Docker installed in your machine. *In case you need to install Docker:* [Rancher Desktop](https://docs.rancherdesktop.io/getting-started/installation/)

4. Run the application using Docker compose. And after running the commands below, open `http://localhost/` and `http://localhost/result` in your browser.
```
cd ./apps
docker compose -d up
docker ps -n=7
```

5. Run the application using Kubernetes. *Make sure that you have kubernetes installed in your machine*

6. To deploy the application in a Kubernetes cluster, you should first push the Docker images to your Docker Hub and then make necessary modifications to the manifest files.

To push you docker images to your Docker Hub you need to run `docker login` and input your credentials.

After that, you need to modify the `./scripts/02-build-image.sh` and change these characters with your own username in Docker Hub:
`966437228244.dkr.ecr.ap-southeast-1.amazonaws.com`

And then run the script to push your images to Docker Hub. Just change the `param1` to [`vote`, `result`, `worker`, `seeder`] and hit enter.
```
# Make sure you are in root directory of the project
./scripts/02-build-images.sh <param1> 1.0
```

After that, you need to modify these files to match the images you pushed in you Docker Hub:
   - `./kubernetes/manifests/deployments/vote_app_deployment.yaml`
   - `./kubernetes/manifests/deployments/result_app_deployment.yaml`
   - `./kubernetes/manifests/deployments/worker_app_deployment.yaml`
   - `./kubernetes/manifests/deployments/seeder_app_deployment.yaml`
You need to change the `image` tag below the `containers` tag to match the image you pushed to the Docker Hub.

7. After all the file modifications in `step: 6`, you can now deploy the application to k8s using the commands below. Replace `param1` to [`config`, `svc`, `db`, `apps`, `extras`] and run in **exact order** to avoid errors.
```
# Make sure you are in root directory of the project
./scripts/03-build-k8s.sh <param1>
```

8. Check if all your resources are running by running the command below. Access the application through `http://localhost/`. *Make sure port 80 is available and if not, just modify the port in `./kubernetes/manifests/services/proxy_service.yaml`*
```
kubectl get all -n cloud
```

9. Add observability using Prometheus by running the command below. To access Grafana, just check for `external-ip` of `grafana-ui` in `kubectl get svc -n cloud`. *To login use these credentials: admin / prom-operator*
```
./scripts/04-build-prometheus.sh
```