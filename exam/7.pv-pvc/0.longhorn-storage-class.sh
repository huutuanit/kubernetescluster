sudo mkdir -p /data/longhorn-storage
cd /home/sysadmin/kubernetes_installation
mkdir longhorn-storage
cd longhorn-storage

cd /home/sysadmin/kubernetes_installation/longhorn-storage
cp longhorn/values.yaml values-longhorn.yaml
# cài thêm open-iscsi cho các Worker Node để nó có thể mount được phân vùng từ longhorn storage
sudo yum -y install iscsi-initiator-utils

helm install longhorn-storage -f values-longhorn.yaml longhorn --namespace storage
