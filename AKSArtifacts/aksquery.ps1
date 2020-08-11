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


kubectl describe pod mssql-staff-767fd8fc45-rjjn9 -n k8-org
kubectl describe pod mssql-product-fb9666fcc-4rcg7 -n k8-org
kubectl describe pod staff-78bcf8c449-sbz2t   -n k8-org
kubectl describe pod nginx-ingress-controller-5dcf6dd88d-rhf5w -n k8-org
