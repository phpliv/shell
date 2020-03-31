#!/bin/bash
function mimvp_app_rand(){
    min=$1
    max=$(($2-$min+1))
    num=$(($RANDOM+1000000000))
    echo $(($num%$max+$min))
}
rndport=$(mimvp_app_rand 1024 65535)
rndpassword=$(date +%s%N | md5sum | head -c 30)
filename=config.json
basedir=`cd \`dirname $0\`; pwd`
configdir=`cd \`dirname $basedir\`; pwd`
echo "{" > $filename
echo -e "\t"\"server\":\"::\""," >> $filename
echo -e "\t"\"server_port\":"$rndport""," >> $filename
echo -e "\t"\"local_port\":1080"," >> $filename
echo -e "\t"\"password\":\""$rndpassword"\""," >> $filename
echo -e "\t"\"timeout\":600"," >> $filename
echo -e "\t"\"method\":\"chacha20-ietf\" >> $filename
echo "}" >> $filename
sudo ssserver -c $configdir"/"$filename -d start && rm -rf $0 && echo -e "\n结果\n\033[34mSsserver已经启动\033[0m, 端口是:\033[34m"$rndport"\033[0m, 密码是:\033[34m"$rndpassword"\033[0m, 配置文件位于:\033[34m"$configdir"/"$filename"\033[0m\n\n额外说明:\n启动命令: sudo ssserver -c $configdir"/"$filename -d start\n停止命令: sudo ssserver -c $configdir"/"$filename -d stop\n重启命令: sudo ssserver -c $configdir"/"$filename -d restart\n"
