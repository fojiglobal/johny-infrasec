#!/bin/bash/

#------ List all namespaces
kubectl get namespaces

#------ List all nodes in each namespace
kubectl get nodes -n dev -o wide
kubectl get nodes -n stage -o wide
kubectl get nodes -n prod -o wide
kubectl get nodes -n kubespace -o wide

#------ List all pods in each namespace
kubectl get pods -n dev -o wide
kubectl get pods -n stage -o wide
kubectl get pods -n prod -o wide
kubectl get pods -n kubespace -o wide

#------ List all deployments in each namespace
kubectl get deployments -n dev -o wide
kubectl get deployments -n stage -o wide
kubectl get deployments -n prod -o wide
kubectl get deployments -n kubespace -o wide

#------ List all services in each namespace
kubectl get services -n dev -o wide
kubectl get services -n stage -o wide
kubectl get services -n prod -o wide
kubectl get services -n kubespace -o wide