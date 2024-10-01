<!-- FROM centos:latest
# LABEL key="value"
RUN yum install -y httpd \
    zip \
    unzip
ADD https://www.free-css.com/assets/files/free-css-templates/download/page291/elearning.zip /var/www/html
WORKDIR /var/www/html
RUN unzip photogenic.zip
RUN cp -rvf photogenic/* .
RUN rm -rf photogenic photogenic.zip
COPY index.html /var/www/html
EXPOSE 80
CMD ["/usr/sbin/httpd","-D","FOREGROUND"]
EXPOSE 80 22 -->


![[Pasted image 20240930151356.png]]

This will be a deployment over a kubernetes cluster using jenkins.
- Developer will write a docer file then push the github
- This will notify jenkin through webhooks and it will start builing
- Jenkins will also copy all the code from the Github repo
- Jenkins will also ssh into ansible server, which will build the docker image based on docker file then tag it and push to docker hub
- Anisble will ssh into kubernates cluster server and run a play book.

## Prerequisite
git, linux, docker, DockerHub account, Ansible, Kubernetes (deployment and service)

3 ec3 instances

1. Jenkins (default-jre+ jenkins)
- normal t2 micro
3. Ansible (Python+ansible+docker)
- normal t2 micro
5. Webapp (kubernetes cluster)--> (docker+minikube)
- t2 medium
## Install jenkins on ubuntu 24.04
https://www.linuxtechi.com/how-to-install-jenkins-on-ubuntu/

### Jenkins plugins
https://plugins.jenkins.io/ssh-agent/

## Install Python, Ansible, Docker

- Ansible install script
```bash
sudo apt-add-repository ppa:ansible/ansible -y

sudo apt update -y

sudo apt install ansible -y
```

[apt-add-repository](https://manpages.debian.org/unstable/software-properties-common/apt-add-repository.1.en.html)

Add the ansible repo to /etc/apt/sources.list just incase it's not there.

- Docker install script
```bash
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sleep 10
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin


```

- Minikube install scripts
```bash
# Update package list 
sudo apt update 
# Install required dependencies 
sudo apt install -y curl apt-transport-https 
# Download latest Minikube binary 
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 
# Install Minikube 
sudo install minikube-linux-amd64 /usr/local/bin/minikube 
# Remove downloaded binary 
rm minikube-linux-amd64 
# Install kubectl 
sudo snap install kubectl --classic 
# Verify installations 
minikube version kubectl version --client # Start Minikube 
minikube start echo "Minikube and kubectl have been installed successfully." echo "Minikube cluster is now running. You can access the dashboard with: minikube dashboard"
```

-Must be force start
```
minikube start --force
```