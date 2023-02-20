# Deploy-python-app-GCP

### Project Details
Create 1 VPC
Create 2 subnets (management subnet & restricted subnet):
1. Management subnet has the following:
    - NAT gateway
    - Private VM
2. Restricted subnet has the following:
    - Private standard GKE cluster (private control plan)
##### Notes:
1. Restricted subnet must not have access to internet
2. All images deployed on GKE must come from GCR or Artifacts registry.
3. The VM must be private.
4. Deployment must be exposed to public internet with a public HTTP load balancer.
5. All infra is to be created on GCP using terraform.
6. Deployment on GKE can be done by terraform or manually by kubectl tool.
7. The code to be build/dockerized and pushed to GCR is on here:
https://github.com/atefhares/DevOps-Challenge-Demo-Code
8. Don’t use default compute service account while creating the gke cluster, create
custom SA and attach it to your nodes.
9. Only the management subnet can connect to the gke cluster.

### Tools Used
    - Terraform
    - GCP
    - Docker
    - Kubernetes
    - Python

### Get Started

1. You should create the infrastructure first
    - terraform init
    - terraform fmt ---------> used to rewrite Terraform configuration files
    - terraform validate ----> validates the configuration files in a directory
    - terraform plan --------> creates an execution plan, which lets you preview the changes 
    - terraform apply -------> command executes the actions proposed in a Terraform plan.
    

2. Build your Docker images and push it in your Repo in Container Registery by using some commands after build your images, activate docker service account and docker configure:
    - docker build -t gcp-python .
    - docker tag gcp-python:latest gcr.io/your project-id/gcp-python:latest
    - docker push gcr.io/project-id/gcp-python:latest
### Pull another redis image from docker hub then push it to gcr
file:///home/aya/Desktop/Deploy-python-app-GCP/screenshots/Screenshot%20from%202023-02-18%2017-43-22.png

file:///home/aya/Desktop/Deploy-python-app-GCP/screenshots/Screenshot%20from%202023-02-18%2017-48-47.png

file:///home/aya/Desktop/Deploy-python-app-GCP/screenshots/Screenshot%20from%202023-02-18%2017-49-44.png


### SSH to the private VM:

1. create and run script file to download dependency
    - vi myscript.sh
    - chmod 777 myscript.sh
    - sh myscript.sh

2. connect vm with the gke
    - for my gke the connection commnd
    -  gcloud container clusters get-credentials my-gke-cluster --zone asia-east1-a --project mercurial-time-233114

3. be sure your node is working
    - kubectl get nodes

4. create and rund deployment files
    - kubectl apply -f .
    - kubectl get all

file:///home/aya/Desktop/Deploy-python-app-GCP/screenshots/Screenshot%20from%202023-02-20%2011-42-58.png


5. finally go to Services & Ingress in kubernetes Engine page
    - click on the endpoint

file:///home/aya/Desktop/Deploy-python-app-GCP/screenshots/Screenshot%20from%202023-02-20%2011-41-30.png
