$myResourceGroup="k8rg"
$acrId ="msdemoregistry"
$myAKSCluster="demo-k8cluster"
az login
az aks get-credentials --resource-group  k8rg --name demo-k8cluster

az acr repository list --name msdemoregistry --output table

az aks  browse  --resource-group  k8rg --name $myAKSCluster
  
code . 

az acr login --name $acrId 
az aks update -g $myResourceGroup -n $myAKSCluster --attach-acr $acrId

cd C:\_dev\_github\k8.kubernetesWorld\kubernetesMicroserviceApp\AKSArtifacts\yaml


kubectl config set-context --current --namespace=k8-org

<#************Sql************#>
kubectl create secret generic mssql --from-literal=SA_PASSWORD="Redhat0!" -n k8-org
kubectl get secrets -n k8-org
kubectl delete secret access-tokensecret "mssql"

kubectl apply -f sql-vol.yaml
kubectl describe pvc mssql-data -n k8-org
#kubectl delete pvc mssql-data

kubectl apply -f yaml/sql-product.yaml
kubectl apply -f yaml/sql-staff.yaml
<#************Apps************#>
kubectl apply -f yaml/product.yaml
kubectl apply -f yaml/staff.yaml
kubectl apply -f yaml/sales.yaml
kubectl apply -f yaml/web.yaml

<#************Ingress************#>
kubectl apply -f .\Controller\ingress.yaml