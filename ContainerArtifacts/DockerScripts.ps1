#Reference: https://stormpath.com/blog/tutorial-deploy-asp-net-core-on-linux-with-docker
###########################################################################
########################Create Network####################################
docker network ls --no-trunc
docker network create product_network

docker inspect af1bab7bf641 -f "{{json .NetworkSettings.Networks }}"  
docker inspect f82b1449d36d -f "{{json .NetworkSettings.Networks }}"   # f82b1449d36d  
######################Employee API DEPLOYMENT###################################

cd C:\_dev\_github\k8.kubernetesWorld\k8.kubernetesWorld.Service.Employee
docker build -t k8_employee:rc1 .
docker run -d -p 8081:80  --name employeeservice k8_employee:rc1
Start-Process "http://localhost:8081/weatherforecast"

###########################################################################
######################Persistence API DEPLOYMENT###########################

cd C:\_dev\_github\k8.kubernetesWorld\k8.kubernetesWorld.Service.Persistence
docker build -t k8_persistence:rc1 .
docker run -d -p 8082:80  --name persistservice k8_persistence:rc1
Start-Process "http://localhost:8082/weatherforecast"

docker network connect  product_network persistservice  
###########################################################################
##############################Web DEPLOYMENT###############################

cd C:\_dev\_github\k8.kubernetesWorld\k8.kubernetesWorld.Web
docker build -t k8_web:rc1 .
docker run -d -p 8080:80  --name k8_web k8_web:rc1
Start-Process "http://localhost:8080/home/index"
###########################################################################
########################SQL Docker Hub####################################

docker run -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=Redhat0!" `
   -p 1433:1433 --name sql1 `
   -d mcr.microsoft.com/mssql/server:2019-CU3-ubuntu-18.04

docker exec -it sql1 "bash"
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "Redhat0!"
SELECT * from sys.Databases
Select * from INFORMATION_SCHEMA.TABLES


docker network connect  product_network sql1
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
#########################General Script######################################
docker ps -a            #get all containers
docker images -a        #get all images

docker stop $(docker ps -a -q)         # stop all containers
docker rm $(docker ps -a -q) -f        # remove all containers
docker rmi k8_server_user:rc2.5 -f
docker rmi k8_client_user:rc2.5 -f

docker rmi $(docker images -a -q) -f   # remove all images
docker rmi cfa3b0c1b405 -f
docker rmi $(docker images -f “dangling=true” -q)  #remove all images with <none>

#########################Docker Compose ###################################
cd C:\_dev\_code\_github\aspnetcore_docker
docker-compose build

docker-compose up --build -d
Start-Process "http://localhost:8080/swagger"
Start-Process "http://localhost:8081/swagger"

docker-compose down

###########################################################################
######################### IGNORE ##########################################
###########################################################################
docker images --filter "label=automation"

docker build -f "C:\_dev\k8.docker\k8.docker.app.client.user\Dockerfile" -t k8dockerappclientuser:dev --target base  --label "com.microsoft.created-by=visual-studio" "C:\_dev\_code\k8.docker"

docker build -t k8_client_user:release .

docker run -it --rm -p 80:81 --name userclient k8_client_user:release

docker build -f "Dockerfile" -t k8_client_user:release --target base .  #--label "com.microsoft.created-by=automation" "C:\_dev\_code\k8.docker"

docker run -d -p 8080:5001  --name userclient k8dockerappclientuser:dev

docker build -f Dockerfile -t dockertest:dev --target base .
docker run -d -p 8080:5001  --name userclient dockertest:dev

docker inspect -f "{{ .NetworkSettings.Networks.nat.IPAddress }}" a356dff75862
docker inspect  f3374ecab85a

docker exec -it userclient /bin/bash

docker logs --follow f3374ecab85a

docker pull khanasif1/k8_client_user:rc2
docker run -d -p 8080:5001  --name kahnasif1user 1b7f0ce78ce9
docker pull khanasif1/k8_server_user:rc1
docker run -d -p 8081:5002  --name kahnasif1server 47a3726cfa6e