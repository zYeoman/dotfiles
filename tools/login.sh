#!/bin/bash
#*/10 * * * * /bin/sh /etc/storage/cron/crontabs/thunetlogin.sh

# net.tsinghua.edu.cn 166.111.204.120
# auth4.tsinghua.edu.cn 101.6.4.100
# ac_id=167 for Rohm EE Hall; others will return "E2833: Your IP address is not in the dhcp table. Maybe you need to renew the IP address." when auth offline
# ac_id=161 for Dorm #31
# ac_id=163 for Dorm ZJ#18

ACID="167"
USER="xxxAccount"
#PASSWORD=`echo -n $PASSWORD|md5sum|cut -d' ' -f1`
#PASSWORD="<passwd>"
PASSWORD="xxxxxxMD5"

[ $(ping -W 2 -c 2 223.6.6.6 | grep -c ttl) -eq 0 ] \
	&& curl -k 'http://101.6.4.100/do_login.php' -X 'POST' --data "ac_id=${ACID}&action=login&username=${USER}&password={MD5_HEX}${PASSWORD}" \
  && sleep 12 \
  && [ $(ping -W 2 -c 2 223.6.6.6 | grep -c ttl) -eq 0 ] \
 	&& curl -k 'http://101.6.4.100/do_login.php' -X 'POST' --data "ac_id=${ACID}&action=login&username=${USER}&password={MD5_HEX}${PASSWORD}"

sleep 10 && wget www.baidu.com -T 2 -t 1 -O /dev/null && sleep 10 && wget https://www.tsinghua.edu.cn/ -T 2 -t 1 -O /dev/null

