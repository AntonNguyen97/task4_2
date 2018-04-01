#!/bin/bash
taskdir=$(pwd);
checkntp=`ls -la /etc/ | grep 'ntp.conf' | wc -l`
if [ ${checkntp} -eq 0 ]; then
apt-get -y install ntp
else
echo "NTP already installed!"
fi

cd /etc
cat ntp.conf | sed '18c\server 0.ua.pool.ntp.org iburst' > ntp2.conf
rm ntp.conf
mv ntp2.conf ntp.conf
cat ntp.conf | sed '19c\ ' > ntp2.conf
rm ntp.conf
mv ntp2.conf ntp.conf
cat ntp.conf | sed '20c\ ' > ntp2.conf
rm ntp.conf
mv ntp2.conf ntp.conf
cat ntp.conf | sed '21c\ ' > ntp2.conf
rm ntp.conf
mv ntp2.conf ntp.conf
cat ntp.conf | sed '24c\ ' > ntp2.conf
rm ntp.conf
mv ntp2.conf ntp.conf
cp ntp.conf ntp2.conf
# замена дефолтных серверов
service ntp restart
cd
cd "$taskdir"
dir=$(pwd);

cp "$dir/ntp_verify.sh" "/tmp/ntp_verify.sh"
echo "*/5 * * * * /tmp/ntp_verify.sh > /var/mail/root" > root | cp root /var/spool/cron/crontabs
rm root
