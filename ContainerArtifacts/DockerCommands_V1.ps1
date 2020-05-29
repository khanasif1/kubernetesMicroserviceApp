#########################General Script######################################
docker ps -a            #get all containers
docker images -a   --format 'table {{.Repository}}\t{{.Tag}}\t{{.ID}}\t{{.CreatedAt}}\t{{.Size}}'      #get all images

docker image prune -a --force --filter "until=2020-04-25T00:00:00"

docker rm f82b1449d36d -f
docker stop $(docker ps -a -q)         # stop all containers
docker rm $(docker ps -a -q) -f        # remove all containers
docker rmi k8_server_user:rc2.5 -f
docker rmi k8_client_user:rc2.5 -f

docker rmi $(docker images -a -q) -f   # remove all images     
docker rmi $(docker images -f “dangling=true” -q)  #remove all images with <none> 
docker rmi k8_persistence:rc1 -f  

docker rm staffservice -f
docker rmi k8_staff:rc1 -f 

docker rm productservice -f
docker rmi k8_product:rc1 -f

docker rm staffservice -f
docker rmi k8_staff:rc1 -f

docker rm web -f
docker rmi k8_web:rc1 -f
docker rmi $(docker images -f “dangling=true” -q)  #remove all images with <none> 

docker rm sqlproduct -f  #SQL remove
docker rm sqlstaff -f  #SQL remove

docker rm k8.kubernetesWorld.Service.Employee -f
docker rmi k8kubernetesworldserviceemployee:dev -f  

docker rm k8.kubernetesWorld.Service.Products -f
docker rmi k8kubernetesworldserviceproducts:dev -f  

docker rm sqlemployee -f
docker rm 5baeaeee2d90 -f
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