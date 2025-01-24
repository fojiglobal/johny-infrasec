#!/bin/bash/

#---------- Create namespaces

kubectl create namespace dev
kubectl create namespace stage
kubectl create namespace prod

#---------- Deploying juiceshop app to each environment/namespaces

kubectl apply -f juiceapp-dev.yml -n dev 
kubectl apply -f juiceapp-stage.yml -n stage 
kubectl apply -f juiceapp-prod.yml -n prod 