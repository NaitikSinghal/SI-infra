#!/bin/bash
# Install PV and PVC
# kubectl apply -f persistent-volume.yaml
# kubectl apply -f persistent-volume-claim.yaml

# Install MySQL
helm install mysql ./helm-charts/mysql
# Install WordPress
helm install wordpress ./helm-charts/wordpress
# Install Nginx
helm install nginx ./helm-charts/nginx
# Install Prometheus
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install prometheus prometheus-community/prometheus -f ./monitoring/prometheus/values.yaml
# Install Grafana
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
helm install grafana grafana/grafana -f ./monitoring/grafana/values.yaml
echo "All components have been installed successfully."


# chmod +x helm_install.sh
# ./helm_install.sh