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