openssl req -nodes -newkey rsa:2048 -keyout tls.key  -out ca.csr -subj "/CN=Tuanch"
openssl x509 -req -sha256 -days 365 -in ca.csr -signkey tls.key -out tls.crt

kubectl create secret generic kubernetes-dashboard-certs --from-file=certs -n kubernetes-dashboard