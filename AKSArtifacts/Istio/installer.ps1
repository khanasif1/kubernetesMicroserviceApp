<#************************************SOURCE*****************************************************************
https://docs.microsoft.com/en-us/azure/aks/servicemesh-istio-install?pivots=client-operating-system-windows
************************************************************************************************************#>

# Specify the Istio version that will be leveraged throughout these instructions
$ISTIO_VERSION="1.7.3"

[Net.ServicePointManager]::SecurityProtocol = "tls12"
$ProgressPreference = 'SilentlyContinue'; Invoke-WebRequest -URI "https://github.com/istio/istio/releases/download/$ISTIO_VERSION/istioctl-$ISTIO_VERSION-win.zip" -OutFile "istioctl-$ISTIO_VERSION.zip"
Expand-Archive -Path "istioctl-$ISTIO_VERSION.zip" -DestinationPath .

# Copy istioctl.exe to C:\Istio
New-Item -ItemType Directory -Force -Path "C:\Program Files\Istio"
Move-Item -Path .\istioctl.exe -Destination "C:\Program Files\Istio\"

# Add C:\Istio to PATH. 
# Make the new PATH permanently available for the current User
$USER_PATH = [environment]::GetEnvironmentVariable("PATH", "User") + ";C:\Program Files\Istio\"
[environment]::SetEnvironmentVariable("PATH", $USER_PATH, "User")
# Make the new PATH immediately available in the current shell
$env:PATH += ";C:\Program Files\Istio\"

<#************************
*****Install on AKS*******
***************************#>
istioctl operator init

kubectl get pods all -n istio-operator

istioctl profile dump default

#Create the istio-system namespace
kubectl create ns istio-system
kubectl apply -f .\istio.aks.yaml --namespace istio-system
kubectl get all -n istio-system
#additional insight into the installation by watching the logs for the Istio Operator.
kubectl logs -n istio-operator -l name=istio-operator -f

kubectl get svc istio-ingressgateway -n istio-system

#automatic sidecar injection
kubectl label namespace k8-org istio-injection=enabled
#verify label
kubectl get namespace -L istio-injection

<#************************
        Dashboards
************************#>
#Grafana
istioctl dashboard grafana
#Prometheus
istioctl dashboard prometheus
#Jaeger
istioctl dashboard jaeger
#Kiali
istioctl dashboard kiali
#Envoy
#istioctl dashboard envoy <pod-name>.<namespace>


