helm repo update
helm install prometheus stable/prometheus-operator

helm ls --all

kubectl get statefulset
#helm del prometheus --purge


#Get configuration files
kubectl get statefulset
kubectl describe statefulset prometheus-prometheus-prometheus-oper-prometheus > prometheus.yaml
kubectl describe statefulset alertmanager-prometheus-prometheus-oper-alertmanager > alert.yaml

kubectl get deployment
kubectl describe deployment prometheus-prometheus-oper-operator  > operator.yaml

kubectl get pod
kubectl logs prometheus-grafana-56d4546b4f-dwc7s -c grafana

kubectl port-forward deployment/prometheus-grafana 3000
