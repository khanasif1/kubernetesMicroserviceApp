kubectl config set-context --current --namespace=k8-org

kubectl create namespace k8-org
kubectl get namespace
kubectl get nodes --watch 
kubectl get deployment -n k8-org
kubectl get services -n k8-org
kubectl get pods -n k8-org
kubectl get pods -n nginx-ingress-controller-5dcf6dd88d-rhf5w 
  

kubectl exec -it --namespace=k8-org staff-6ff4766cb6-scwqh    -- /bin/sh
curl -i -X GET "http://10.0.213.13/swagger/index.html"
curl -i -X GET "http://10.0.213.13/api/staff/GetMetadata"
curl -i -X GET "http://10.0.213.13/api/staff"


kubectl exec -it --namespace=k8-org product-9d5658b6-46rzd    -- /bin/sh
curl -i -X GET "http://10.0.237.154/swagger/index.html"
curl -i -X GET "http://10.0.237.154/api/product/GetMetadata"
curl -i -X GET "http://10.0.237.154/api/product"

kubectl exec -it --namespace=k8-org sales-5f7dcccd44-bf55t    -- /bin/sh
curl -i -X GET "http://10.0.207.121/health"
curl -i -X GET "http://10.0.207.121/api/sales"

kubectl exec -it --namespace=k8-org web-bfdbf7f45-cnnxg     -- /bin/sh
curl -i -X GET "http://10.0.53.59/health"
curl -i -X GET "http://10.0.53.59"


kubectl describe pod web-bfdbf7f45-54z8b  -n k8-org
kubectl describe pod product-9d5658b6-46rzd     -n k8-org
kubectl describe pod staff-78bcf8c449-sbz2t   -n k8-org
kubectl describe pod sales-5f7dcccd44-pwtgw  -n k8-org
kubectl describe pod web-bfdbf7f45-bqr7v   -n k8-org
kubectl describe pod nginx-ingress-controller-5dcf6dd88d-rhf5w -n k8-org


az ad sp create-for-rbac --skip-assignment --name azure-arc-onpremserver-sp
<#{
  "appId": "1881b488-c0fe-4157-aa6e-c37af0ca596b", 
  "displayName": "azure-arc-onpremserver-sp",      
  "name": "http://azure-arc-onpremserver-sp",      
  "password": "Vcx-ED6lbWlFZDMZCyh3G~PC~OJaimVtwu",
  "tenant": "72f988bf-86f1-41af-91ab-2d7cd011db47" 
}
#>

azcmagent connect --service-principal-id 1881b488-c0fe-4157-aa6e-c37af0ca596b --service-principal-secret Vcx-ED6lbWlFZDMZCyh3G~PC~OJaimVtwu --tenant-id 72f988bf-86f1-41af-91ab-2d7cd011db47 --subscription-id 9907fc36-386a-48e6-9b00-0470d5f7cab7 --resource-group ArcRG --location australiaeast
az ad sp create-for-rbac --skip-assignment --name renew-demo-k8clusterSP

<#
{
  "appId": "a53fda91-5eb2-4d2b-8bc8-b2b94a0a302b",
  "displayName": "renew-demo-k8clusterSP",
  "name": "http://renew-demo-k8clusterSP",
  "password": "Rbo-bzoVx_0n_o.Fe43op~BFrLCf9HV44E",
  "tenant": "72f988bf-86f1-41af-91ab-2d7cd011db47"
}
#>
az ad sp credential reset  --name "k8msdemoSP-20200216171301" --years 2
<#{
  "appId": "793cb9ea-0e79-47f8-aade-ce230ea4efce",
  "name": "k8msdemoSP-20200216171301",
  "password": "0V1o4Rs..eQ4HNE56RtRycEsryhqn.-yMY",
  "tenant": "72f988bf-86f1-41af-91ab-2d7cd011db47"
}#>
az ad sp credential reset  --name "demo-k8clusterSP-20200218180741" --years 2
<#{
    "appId": "068145ab-33be-4408-b391-7f6f1ae00875",
    "name": "demo-k8clusterSP-20200218180741",
    "password": "ntRcgO~-CcsNa9b6p6L60~yxKntXuvnR9X",
    "tenant": "72f988bf-86f1-41af-91ab-2d7cd011db47"
}#>
az aks update-credentials --resource-group k8rg --name demo-k8cluster --reset-service-principal --service-principal 'a53fda91-5eb2-4d2b-8bc8-b2b94a0a302b' --client-secret 'Rbo-bzoVx_0n_o.Fe43op~BFrLCf9HV44E'

