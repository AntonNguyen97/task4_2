#!/bin/bash

cd /etc
checkntp=`ps aux | grep "ntp root" | wc -l`

if [ "$checkntp" -eq 1 ]; then
        echo "NTP running!"
else
      echo "NOTICE: ntp is not running!"
      service ntp start
fi
difference=`diff ntp2.conf ntp.conf | wc -l `

diff ntp.conf ntp2.conf > /var/mail/root

if [ "$difference" -eq 0 ]; then
           echo "No changes at ntp.conf" > /var/mail/root
else
           rm ntp.conf
           echo "Notice: ntp.conf was changed. Calculated difference: "
           diff -u0 /etc/ntp2.conf /etc/ntp.conf
           cp ntp2.conf ntp.conf
           service ntp restart
fi
