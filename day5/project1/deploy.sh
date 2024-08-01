#!/bin/bash

# Initialize Docker Swarm
docker swarm init --advertise-addr 172.25.9.179

# Create Docker Swarm Service
docker service create --name nginx-service --publish 8081:80 nginx

# Start Minikube
minikube start

# Create Kubernetes Deployment
kubectl apply -f webapp-deployment.yaml

# Expose the Deployment
kubectl expose deployment webapp --type=NodePort --port=80

# Deploy Web App Using Docker Compose
docker-compose -f docker-compose-single-volume.yml up -d

echo "Deployment completed successfully!"
