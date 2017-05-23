#/bin/sh

## 根据lastb 的结果生成屏蔽 IP 列表并加入到 ufw 中

PATH=/usr/bin:/usr/sbin:/sbin:/bin

#set -x
lastb -s -2days | awk '{print $3 }' | sed -e 's/[0-9]\{1,3\}$/0\/24/g' | sort | uniq -c | sort -r -g |grep -E '/[0-9]+$' > bad_ip

while read count subnet
do
    echo $count $ip
    if [ $count -gt 100 ]
    then
        #iptables -A INPUT -s $ip -p tcp --destination-port 22 -j DROP
        ufw deny proto tcp from $subnet to any port 22
    fi
done < ./bad_ip
