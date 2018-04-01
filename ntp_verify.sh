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

diff -u0 ntp.conf ntp2.conf > /var/mail/root

if [ "$difference" -eq 0 ]; then
           echo "No changes at ntp.conf" > /var/mail/root
else
           echo "Notice: ntp.conf was changed. Calculated difference: "
           diff -u0 ntp2.conf ntp.conf
           cp -f ntp2.conf ntp.conf
           service ntp restart
fi

