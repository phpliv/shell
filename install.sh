#!/bin/bash
function mimvp_app_rand(){
    min=$1
    max=$(($2-$min+1))
    num=$(($RANDOM+1000000000))
    echo $(($num%$max+$min))
}
rndport=$(mimvp_app_rand 1024 65535)
rndpassword=$(date +%s%N | md5sum | head -c 30)
ipaddress=$(ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d "addr:")
filename=config.json
rndmethod=xchacha20-ietf-poly1305
basedir=`cd \`dirname $0\`; pwd`
configdir=`cd \`dirname $basedir\`; pwd`
echo "{" > $filename
echo -e "\t"\"server\":\"::\""," >> $filename
echo -e "\t"\"server_port\":"$rndport""," >> $filename
echo -e "\t"\"local_port\":1080"," >> $filename
echo -e "\t"\"password\":\""$rndpassword"\""," >> $filename
echo -e "\t"\"timeout\":600"," >> $filename
echo -e "\t"\"method\":\""$rndmethod"\" >> $filename
echo "}" >> $filename
sudo ssserver -c $configdir"/"$filename -d start && rm -rf $0 && echo -e "\n\n\033[34mSsserver已经启动\033[0m, 配置文件位于:\033[34m"$configdir"/"$filename"\033[0m, 可自行修改, 但需重启.\nIP:\033[34m"$ipaddress"\033[0m\n端口:\033[34m"$rndport"\033[0m\n密码:\033[34m"$rndpassword"\033[0m\n加密方法:\033[34m"$rndmethod"\033[0m \n\n说明:\nssserver启动命令: sudo ssserver -c $configdir"/"$filename -d start\nssserver停止命令: sudo ssserver -c $configdir"/"$filename -d stop\nssserver重启命令: sudo ssserver -c $configdir"/"$filename -d restart\n"
