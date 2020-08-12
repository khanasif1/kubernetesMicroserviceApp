<#*********************
    Login 
*********************#>
az login
az acr login --name msdemoregistry 
az acr repository list --name msdemoregistry --output table
docker images -a
#docker rmi 3a48e3ebf9ac -f
<#*********************
Upload Product Image
*********************#>
#Tag images
docker tag k8_product:rc1  msdemoregistry.azurecr.io/k8_product:1.00
#******Test Tag Image******
#docker run -d -p 8082:80  --name productservice msdemoregistry.azurecr.io/k8_product:1.0
#Push to ACR
docker push msdemoregistry.azurecr.io/k8_product:1.00

<#*********************
Upload Staff Image
*********************#>
#Tag images
docker tag k8_staff:rc1  msdemoregistry.azurecr.io/k8_staff:1.00
#******Test Tag Image******
#docker run -d -p 8083:80  --name staffservice msdemoregistry.azurecr.io/k8_staff:1.0
#Push to ACR
docker push msdemoregistry.azurecr.io/k8_staff:1.00

<#*********************
Upload Sales Image
*********************#>
#Tag images
docker tag k8_sales:rc1  msdemoregistry.azurecr.io/k8_sales:1.00
#******Test Tag Image******
#docker run -d -p 8085:80  --name saleservice msdemoregistry.azurecr.io/k8_sales:1.0
#Push to ACR
docker push msdemoregistry.azurecr.io/k8_sales:1.00

<#*********************
Upload Web Image
*********************#>
#Tag images
docker tag k8_web:rc1  msdemoregistry.azurecr.io/k8_web:1.0
<#******Test Tag Image******#>
#docker run -d -p 8080:80  --name webservice msdemoregistry.azurecr.io/k8_web:1.0
#Push to ACR
docker push msdemoregistry.azurecr.io/k8_web:1.0

