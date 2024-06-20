#!/bin/bash

set -e

if ! minikube status > /dev/null 2>&1; then
    echo "Starting Minikube..."
    minikube start
else
    echo "Minikube is already running."
fi


echo "Enabling Ingress addon..."
minikube addons enable ingress

export MINIKUBE_IP=$(minikube ip)
echo "Minikube IP is set to $MINIKUBE_IP"

NAMESPACE="accommodatio"
kubectl create namespace $NAMESPACE

echo "Applying Kubernetes secrets..."
kubectl apply -f secret.yaml --namespace $NAMESPACE

echo "Deploying Helm chart..."
helm install release ./accommodatio-app --set global.minikubeIp=$MINIKUBE_IP --namespace $NAMESPACE

echo "Deployment complete"
