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
    - Docker & GCR
    - Kubernetes & GKE
    

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

![Screenshot from 2023-02-18 17-43-22](https://user-images.githubusercontent.com/68289149/220080785-9cb0e45a-9126-42ae-a129-8d3c28dd1a00.png)

![Screenshot from 2023-02-18 17-48-47](https://user-images.githubusercontent.com/68289149/220080795-74e2f9d5-072b-4d96-be04-12fd8abd1d5b.png)

![Screenshot from 2023-02-18 17-49-44](https://user-images.githubusercontent.com/68289149/220080823-2aa68e45-d198-446f-91ee-7b96d2ba900f.png)


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

![Screenshot from 2023-02-20 11-40-08](https://user-images.githubusercontent.com/68289149/220081085-effc24ef-ba9d-4162-9e30-d504d0e453fe.png)

![Screenshot from 2023-02-20 11-42-58](https://user-images.githubusercontent.com/68289149/220081110-78bba1ec-460b-4922-99c8-d302c1aba9c5.png)

5. finally go to Services & Ingress in kubernetes Engine page
    - click on the endpoint
![Screenshot from 2023-02-20 11-41-30](https://user-images.githubusercontent.com/68289149/220081201-681707d8-5faf-496b-84a7-cf7d768d4d97.png)


