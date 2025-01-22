#!/bin/bash/

#---------- Create namespaces

kubectl create namespace dev
kubectl create namespace stage
kubectl create namespace prod

#---------- Deploying juiceshop app to each environment/namespaces

kubectl apply -f juiceapp-dev.yml -namespace dev 
kubectl apply -f juiceapp-stage.yml -namespace stage 
kubectl apply -f juiceapp-prod.yml -namespace prod 