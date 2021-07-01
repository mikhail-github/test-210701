# Test task

### Step by step setup instruction

* Make shure you have [minikube](https://minikube.sigs.k8s.io/docs/start/) installed and started
* Download the sample [application](https://github.com/sawasy/http_server/blob/main/http_server.rb) and save it to http-app folder
* Change the port number in line 3 of http_server.rb file from 80 to 8000
* Run in shell to point docker command to minikube daemon 
```shell
eval $(minikube docker-env)
```
* Build application docker image
```shell
docker build -t http-app:latest http-app
```

### Architecture

### Usage instruction
