#!/bin/sh

# 使用FTP协议获取最新的互联网地址分配信息

get_delegated(){
    if [ $1=ripe ];then
        host=ftp.ripe.net
    else
        host=ftp.${1}.net
    fi
    ftp -n <<!
open $host
user anonymous ''
bin
cd pub/stats/${1}
lcd ~/down
prompt
get delegated-${1}-extended-latest
close
bye
!
}

params="apnic arin lacnic ripencc afrinic"

for param in $params
do
    get_delegated $param
done

