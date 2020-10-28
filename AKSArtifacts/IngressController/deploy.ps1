kubectl config set-context --current --namespace=k8-org

kubectl apply -f .\IngressController\ingress.yaml
