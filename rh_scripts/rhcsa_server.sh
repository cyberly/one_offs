lab nfsmount setup
mkdir -p /nfs/{1,2,3,4,5}
chmod 777 /nfs/{1,2,3,4,5}
for i in 1 2 3 4 5; do
  echo "lol hi" > /nfs/${i}/${i}.txt
done
echo "/nfs/1    172.25.0.0/16(sec=krb5p,rw,sync)" >> /etc/exports
echo "/nfs/2    172.25.0.0/16(sec=krb5p,rw,sync)" >> /etc/exports
echo "/nfs/3    172.25.0.0/16(sec=krb5p,rw,sync)" >> /etc/exports
echo "/nfs/4    172.25.0.0/16(sec=krb5p,rw,sync)" >> /etc/exports
echo "/nfs/5    172.25.0.0/16(sec=krb5p,rw,sync)" >> /etc/exports
exportfs -r
