kubectl config set-context --current --namespace=k8-org

kubectl apply -f ..\AKSArtifacts\Controller\ingress.yaml
