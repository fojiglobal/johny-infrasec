#!/bin/bash/

#------ List all namespaces
kubectl get namespaces

#------ List all nodes in each namespace
kubectl get nodes -namespace dev -o wide
kubectl get nodes -namespace stage -o wide
kubectl get nodes -namespace prod -o wide

#------ List all pods in each namespace
kubectl get pods -namespace dev -o wide
kubectl get pods -namespace stage -o wide
kubectl get pods -namespace prod -o wide

#------ List all deployments in each namespace
kubectl get deployments -namespace dev -o wide
kubectl get deployments -namespace stage -o wide
kubectl get deployments -namespace prod -o wide

#------ List all services in each namespace
kubectl get services -namespace dev -o wide
kubectl get services -namespace stage -o wide
kubectl get services -namespace prod -o wide