#!/bin/bash

gcloud config set compute/zone us-central1-f

#Installs Helm if needed

curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get | bash

# Configure HELM for cloud shell

kubectl create serviceaccount tiller --namespace kube-system
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin \
    --serviceaccount=kube-system:tiller
helm init --service-account=tiller
until (timeout 7 helm version > /dev/null 2>&1); do echo "Waiting for tiller install..."; done


export INSTANCE_ID=[bigtable instance name here]

# Deploy JanusGraph Helm

helm install --wait --timeout 600 --name janusgraph stable/janusgraph -f values.yaml

# Verify Helm installation

export POD_NAME=$(kubectl get pods --namespace default -l "app=janusgraph,release=janusgraph" -o jsonpath="{.items[0].metadata.name}")

# connect to the pod and run gremlin

kubectl exec -it $POD_NAME -- /janusgraph-0.2.0-hadoop2/bin/gremlin.sh

# In the Gremlin console, connect to the Apache TinkerPop server:

:remote connect tinkerpop.server conf/remote.yaml session
:remote console



