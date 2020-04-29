﻿#Reference: https://stormpath.com/blog/tutorial-deploy-asp-net-core-on-linux-with-docker
###########################################################################
########################Create Network####################################
docker network ls --no-trunc
docker network create product_network

docker inspect sqlemployee -f "{{json .NetworkSettings.Networks }}" 
docker inspect sqlproduct -f "{{json .NetworkSettings.Networks }}"   
docker inspect employeeservice -f "{{json .NetworkSettings.Networks }}"   # Employee
docker inspect productservice -f "{{json .NetworkSettings.Networks }}"   # Product
docker inspect k8.kubernetesWorld.Service.Employee -f "{{json .NetworkSettings.Networks }}"   # Employee  VS debug 
######################Employee API DEPLOYMENT###################################

# cd C:\_dev\_github\k8.kubernetesWorld\kubernetesMicroserviceApp\k8.kubernetesWorld.Service.Employee
# docker build -t k8_employee:rc1 .
# docker run -d -p 8081:80  --name employeeservice k8_employee:rc1
# #Start-Process "http://localhost:8081/swagger"
# docker network connect  product_network employeeservice 
###########################################################################
######################Product API DEPLOYMENT###########################

cd C:\_dev\_github\k8.kubernetesWorld\kubernetesMicroserviceApp\k8.kubernetesWorld.Service.Product
docker build -t k8_product:rc1 .
docker run -d -p 8082:80  --name productservice k8_product:rc1
#Start-Process "http://localhost:8082/swagger"

docker network connect  product_network productservice  
###########################################################################
######################Staff DEPLOYMENT###########################

cd C:\_dev\_github\k8.kubernetesWorld\kubernetesMicroserviceApp\k8.kubernetesWorld.Service.Staff
docker build -t k8_staff:rc1 .
docker run -d -p 8083:80  --name staffservice k8_staff:rc1
#Start-Process "http://localhost:8083/swagger"

docker network connect  product_network staffservice  
###########################################################################
##############################Web DEPLOYMENT###############################

cd C:\_dev\_github\k8.kubernetesWorld\kubernetesMicroserviceApp\k8.kubernetesWorld.Web
docker build -t k8_web:rc1 .
docker run -d -p 8080:80  --name web k8_web:rc1
Start-Process "http://localhost:8080/home/index"
docker network connect  product_network web
###########################################################################
########################SQL Docker Hub####################################

docker run -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=Redhat0!" `
   -p 1433:1433 --name sqlemployee `
   -d mcr.microsoft.com/mssql/server:2019-CU3-ubuntu-18.04

docker run -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=Redhat0!" `
   -p 1432:1433 --name sqlproduct `
   -d mcr.microsoft.com/mssql/server:2019-CU3-ubuntu-18.04

docker exec -it sqlemployee "bash"
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "Redhat0!"
SELECT NAME from sys.Databases
Select * from INFORMATION_SCHEMA.TABLES


docker network connect  product_network sqlemployee
docker network connect  product_network sqlproduct
###########################################################################
########################Push Docker Hub####################################
docker login -u=khanasif1 -p=Redhat0!
docker tag k8_client_user:rc2.5 khanasif1/k8_client_user:rc2.5
docker push khanasif1/k8_client_user:rc2.5


docker login -u=$$$$ -p=$$$$
docker tag k8_server_user:rc3 khanasif1/k8_server_user:rc3
docker push khanasif1/k8_server_user:rc3

docker pull khanasif1/k8_server_user:rc3
docker run -d -p 80:80  --name userserverdh khanasif1/k8_server_user:rc3
docker inspect ec4b4807ead8