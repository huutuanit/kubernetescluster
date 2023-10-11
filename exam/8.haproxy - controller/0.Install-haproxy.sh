# Tạo namespace có tên ingress-controller
kubectl create ns ingress-controller

kubectl apply -f https://haproxy-ingress.github.io/resources/haproxy-ingress.yaml

# Gán thêm label cho các Node (ví dụ node worker2, worker1 ...)
kubectl label node master role=ingress-controller
kubectl label node worker1 role=ingress-controller
kubectl label node worker2 role=ingress-controller
kubectl label node worker3 role=ingress-controller

# Kiểm tra các thành phần
kubectl get all -n ingress-controller

# change host name
vi /etc/hosts

172.16.10.102 tuanchkubeletes.test

# Tạo một Ingress với cấu hình SSL
openssl req -x509 -newkey rsa:2048 -nodes -days 365 -keyout privkey.pem -out fullchain.pem -subj '/CN=tuanchkubeletes.test'
kubectl create secret tls tuanchkubeletes-test --cert=fullchain.pem --key=privkey.pem -n ingress-controller

