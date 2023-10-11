git clone git@github.com:nginxinc/kubernetes-ingress.git
# vào thư mục tải về
cd kubernetes-ingress
cd deployments

kubectl apply -f common/ns-and-sa.yaml
kubectl apply -f common/default-server-secret.yaml
kubectl apply -f common/nginx-config.yaml
kubectl apply -f rbac/rbac.yaml
kubectl apply -f daemon-set/nginx-ingress.yaml

kubectl get ds -n nginx-ingress
kubectl get po -n nginx-ingress