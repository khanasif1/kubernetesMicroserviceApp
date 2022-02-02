az --version
helm version

# Use Helm to deploy an NGINX ingress controller
helm repo update
helm install nginx-ingress stable/nginx-ingress   `
    --namespace k8-org `
    --set controller.replicaCount=1 `
    --set controller.nodeSelector."beta\.kubernetes\.io/os"=linux `
    --set defaultBackend.nodeSelector."beta\.kubernetes\.io/os"=linux


kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.0.0/deploy/static/provider/baremetal/deploy.yaml


#Verify installation
kubectl get pods -n ingress-nginx \
-l app.kubernetes.io/name=ingress-nginx --watch

ingress-controller --version