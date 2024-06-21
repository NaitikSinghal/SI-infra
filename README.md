# WordPress on Kubernetes with Helm

This project provides a complete setup for deploying a production-grade WordPress application on Kubernetes using Helm. It includes custom Docker images for WordPress, MySQL, and Nginx. Using Helm charts for managing Kubernetes resources.



## Prerequisites

- Docker
- Minikube
- Helm

## Step-by-Step Deployment Guide

### Step 1: Build Docker Images

1. **Build the WordPress Docker image:**
    ```sh
    cd ../wordpress
    docker build -t your-dockerhub-username/wordpress .
    ```

2. **Build the MySQL Docker image:**
    ```sh
    cd ../mysql
    docker build -t your-dockerhub-username/mysql .
    ```

3. **Build the Nginx Docker image:**
    ```sh
    cd ../nginx
    docker build -t your-dockerhub-username/nginx .
    ```

4. **Push the images to Docker Hub:**
    ```sh
    docker push your-dockerhub-username/wordpress
    docker push your-dockerhub-username/mysql
    docker push your-dockerhub-username/nginx
    ```

### Step 2: Configure Helm Charts

Update the `values.yaml` files for each Helm chart with the appropriate Docker image repositories and tags.

### Step 3: Deploy Helm Charts

1. Deploy MySQL
   ```sh
   cd helm-charts/mysql
   helm install mysql .
   ```
   
2. Deploy WordPress:
   ```sh
   cd ../wordpress
   helm install wordpress .
   ```
   
3. Deploy Nginx:
   ```sh
   cd ../nginx
   helm install nginx .
   ```
   
### Step 4: Verify the Deployment

1. Check Pods:
   ```sh
   kubectl get pods
   ```
   
2. Check services:
   ```sh
   kubectl get svc
   ```
   
3. Access wordpress:
   ```sh
   minikube ip
   ```
   
### Step 5: Clean Up
   ```sh
   helm delete mysql
   helm delete wordpress
   helm delete nginx
   ```
### Step 5: Set Up Monitoring
#### Step 5.1: Deploy Prometheus

1. Add the Prometheus Helm repository:
   ```sh
   helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
   helm repo update
   ```
2. Create a namespace for monitoring:
   ```sh
   kubectl create namespace monitoring
   ```
3. Deploy Prometheus:
   ```sh
   helm install prometheus prometheus-community/prometheus -f ./monitoring/prometheus/values.yaml
   ```

#### Step 5.2: Deploy Grafana

1. Add the Grafana Helm repository:
   ```sh
   helm repo add grafana https://grafana.github.io/helm-charts
   helm repo update
   ```
2. Deploy Prometheus:
   ```sh
   helm install grafana grafana/grafana -n monitoring
   ```
3. Get the Grafana admin password:
   ```sh
   kubectl get secret --namespace monitoring grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
   ```
4. Access Grafana:
   ```sh
   kubectl get svc -n monitoring
   ```
   Open the Grafana URL in your browser and log in with the username admin and the password obtained in the previous step.

#### Step 5.4: Create Dashboards
Import predefined dashboards for MySQL, Nginx, and WordPress:

Go to Create > Import.
Use the following dashboard IDs to import:
MySQL: 7362
Nginx: 2135
WordPress: Create a custom dashboard with relevant metrics.   
   


