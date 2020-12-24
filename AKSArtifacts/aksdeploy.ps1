$myResourceGroup="**resource group**"
$acrId ="**ACR name**"
$myAKSCluster="** Cluster Name**"



az login
az aks get-credentials --resource-group  k8rg --name demo-k8cluster

az acr repository list --name msdemoregistry --output table

az aks  browse  --resource-group  k8rg --name $myAKSCluster
  
code . 

az acr login --name $acrId 
az aks update -g $myResourceGroup -n $myAKSCluster --attach-acr $acrId

kubectl config set-context --current --namespace=k8-org

<#************ Staff Sql************#>
kubectl create secret generic mssql --from-literal=SA_PASSWORD="**PWD**" -n "**namespace**"
kubectl get secrets -n k8-org
kubectl describe mssql
kubectl delete secret access-tokensecret "mssql"

kubectl apply -f yaml/staff-sql-vol.yaml
kubectl describe pvc mssql-data -n k8-org
#kubectl delete pvc mssql-data

kubectl apply -f yaml/product-sql.yaml
kubectl apply -f yaml/staff-sql.yaml
<#************ Product  Sql************#>
kubectl create secret generic mssql --from-literal=SA_PASSWORD="**PWD**" -n "**namespace**"
# kubectl get secrets -n k8-org
# kubectl delete secret access-tokensecret "mssql"

kubectl apply -f yaml/product-sql-vol.yaml
kubectl describe pvc product-mssql-data -n k8-org
#kubectl delete pvc mssql-data

kubectl apply -f yaml/product-sql.yaml
<#************Apps************#>
kubectl apply -f yaml/product.yaml
kubectl apply -f yaml/staff.yaml
kubectl apply -f yaml/sales.yaml
kubectl apply -f yaml/web.yaml

<#************Ingress************#>
#kubectl apply -f .\Controller\ingress.yaml