# Test task

### Step by step setup instruction

* Make shure you have [minikube](https://minikube.sigs.k8s.io/docs/start/) installed and started
* Download the sample [application](https://github.com/sawasy/http_server/blob/main/http_server.rb) and save it to http-app folder
* **Update the application code and make sure it returns proper HTTP response with code 200 on healthcheck endpoint, the current implementation causes failures because of improper response**
* Change the port number in line 3 of http_server.rb file from 80 to 8000
* Run in shell to point docker command to minikube daemon 
```shell
eval $(minikube docker-env)
```
* Build application docker image
```shell
docker build -t http-app:v1 http-app
```
* Set appropriate value for kubectl config file and run Terraform init
```shell
KUBE_CONFIG_PATH=~/.kube/config TF_VAR_docker_image=http-app:v1 terraform -chdir=terraform init
```
* Run Terraform apply
```shell
KUBE_CONFIG_PATH=~/.kube/config TF_VAR_docker_image=http-app:v1 terraform -chdir=terraform apply
```

### Architecture

Application is deployed to Kubernetes cluster with multiple replicas and a service to provide external access to HTTP endpoint. 

As Minikube with local Docker registry was used, container image pull policy was set to "Never". In case of external registry this parameter should be changed.   

Please use the corresponding Docker image tag in build and deploy steps.

### Usage instruction

Application endpoint can be accessed from shell
```shell
curl $(minikube service http-app --url)
```
