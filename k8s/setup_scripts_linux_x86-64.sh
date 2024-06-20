#!/bin/bash
#
# Run `source setup_scripts_linux_x86-64.sh` to enable command 
# line functions created in this file.

setup_kubectl() {
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
    kubectl version --client
}

setup_minikube() {
    curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
    sudo install minikube-linux-amd64 /usr/local/bin/minikube && rm minikube-linux-amd64
    minikube start

    minikube addons enable ingress
    echo
    echo "Append the following line to /etc/hosts file:"
    echo "$(minikube ip) api.accommodatio.local"
}

setup_kompose() {
    curl -L https://github.com/kubernetes/kompose/releases/download/v1.34.0/kompose-linux-amd64 -o kompose
    chmod +x kompose
    sudo mv ./kompose /usr/local/bin/kompose
    kompose version
}

setup_helm() {
    curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
}

apply() {
    kubectl apply -R -f $1
}

delete() {
    kubectl delete -R -f $1
}

pods() {
    watch -n 1 "kubectl get pods"
}
