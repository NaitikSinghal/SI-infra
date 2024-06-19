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
    cd Dockerfiles/wordpress
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
