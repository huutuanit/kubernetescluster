git clone https://github.com/nginxinc/kubernetes-ingress.git --branch v3.3.1
cd kubernetes-ingress/deployments

# vào thư mục tải về
kubectl apply -f common/ns-and-sa.yaml
kubectl apply -f ../examples/shared-examples/default-server-secret/default-server-secret.yaml
kubectl apply -f common/nginx-config.yaml
kubectl apply -f rbac/rbac.yaml
kubectl apply -f daemon-set/nginx-ingress.yaml
kubectl apply -f common/ingress-class.yaml
