#!/bin/bash
source ../k8s/setup_scripts_linux_x86-64.sh

if ! command -v kubectl &> /dev/null
then
    setup_kubectl
else
    echo "kubectl is already installed."
fi


if ! command -v minikube &> /dev/null
then
    setup_minikube
elif ! minikube status &> /dev/null
then
    echo "Minikube is not running, starting Minikube..."
    minikube start
else
    echo "Minikube is already installed and running."
fi

apply ../k8s/resources

POD_NAME=$(kubectl get pods --selector=io.kompose.service=api-gateway-service --output=jsonpath='{.items[0].metadata.name}')
echo "When api-gateway pod is up, run 'kubectl port-forward $POD_NAME 4200:4200' to be able to reach it locally."
