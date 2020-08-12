kubectl config set-context --current --namespace=k8-org

kubectl create namespace k8-org
kubectl get namespaces  
kubectl get nodes --watch 
kubectl get deployment  
kubectl get services
kubectl get pods
kubectl get pods -n nginx-ingress-controller-5dcf6dd88d-rhf5w 
  

kubectl exec -it --namespace=k8-org staff-6ff4766cb6-scwqh    -- /bin/sh
curl -i -X GET "http://10.0.213.13/swagger/index.html"
curl -i -X GET "http://10.0.213.13/api/staff/GetMetadata"
curl -i -X GET "http://10.0.213.13/api/staff"


kubectl exec -it --namespace=k8-org product-9d5658b6-46rzd    -- /bin/sh
curl -i -X GET "http://10.0.237.154/swagger/index.html"
curl -i -X GET "http://10.0.237.154/api/product/GetMetadata"
curl -i -X GET "http://10.0.237.154/api/product"


kubectl describe pod mssql-product-547b944d69-kl5gv  -n k8-org
kubectl describe pod product-9d5658b6-46rzd     -n k8-org
kubectl describe pod staff-78bcf8c449-sbz2t   -n k8-org
kubectl describe pod nginx-ingress-controller-5dcf6dd88d-rhf5w -n k8-org
