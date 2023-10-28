#NFS Server installation
sudo -s
yum install nfs-utils -y

#Create shared folder
mkdir -p /data2/delete
mkdir -p /data2/retain

#Change folder
chmod -R 755 /data2
chown -R nfsnobody:nfsnobody /data2
 
systemctl enable rpcbind
systemctl enable nfs-server
systemctl enable nfs-lock
systemctl enable nfs-idmap

systemctl start rpcbind
systemctl start nfs-server
systemctl start nfs-lock
systemctl start nfs-idmap 
#stat service
systemctl restart nfs-server

-----------------------

yum install nfs-utils
systemctl enable rpcbind
systemctl enable nfs-server
systemctl enable nfs-lock
systemctl enable nfs-idmap
systemctl start rpcbind
systemctl start nfs-server
systemctl start nfs-lock
systemctl start nfs-idmap

service nfs start

vi /etc/exports

/data  *(rw,sync,no_subtree_check,insecure)


# Tạo thư mục
mkdir -p /data
chmod -R 777 /data

# export và kiểm tra cấu hình chia sẻ
exportfs -rav
exportfs -v
showmount -e

# Khởi động lại và kiểm tra dịch vụ
systemctl stop nfs-server
systemctl start nfs-server
systemctl status nfs-server

------
# install storage class
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
sudo chmod 700 get_helm.sh
./get_helm.sh

helm list
mkdir -p /home/sysadmin/kubernetes_installation
cd /home/sysadmin/kubernetes_installation
mkdir nfs-storage
cd nfs-storage
# Download helm chart nfs-client-provisioner về để cài offline:
helm repo add stable https://charts.helm.sh/stable
helm search repo nfs-client-provisioner
helm pull stable/nfs-client-provisioner --version 1.2.11
tar -xzf nfs-client-provisioner-1.2.11.tgz

# thay doi tham so mac dinh cua helm
cp nfs-client-provisioner/values.yaml values-nfs-delete.yaml
cp nfs-client-provisioner/values.yaml values-nfs-retain.yaml

#Thay đổi các tham số trong file values-nfs-delete.yaml như sau:
repository: docker.io/vbouchaud/nfs-client-provisioner
tag: latest
replicaCount: 2 
server: 172.168.10.101 # nfs server ip
path: /data2/delete
provisionerName: viettq-nfs-storage-delete-provisioner
name: viettq-nfs-delete
reclaimPolicy: Delete
archiveOnDelete: false
#Thay đổi các tham số trong file values-nfs-retain.yaml như sau:
repository: docker.io/vbouchaud/nfs-client-provisioner
tag: latest
replicaCount: 2 
server: 172.168.10.101
path: /data2/retain
provisionerName: viettq-nfs-storage-retain-provisioner
name: viettq-nfs-retain
reclaimPolicy: Retain
archiveOnDelete: true
#tạo một namespace riêng cho phần storage
kubectl create namespace "storage"
helm install nfs-storage-retain --namespace storage -f values-nfs-retain.yaml nfs-client-provisioner
helm install nfs-storage-delete --namespace storage -f values-nfs-delete.yaml nfs-client-provisioner