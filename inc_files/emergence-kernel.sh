#!/bin/bash
# processname: emergence-kernel
# chkconfig: 2345 95 20
# description: Emergence-Kernel daemon
# processname: emergence-kernel
#5 – chkconfig –level 2345 emergence-kernel on

check_process() {
  echo "checking $1"
  [ "$1" = "" ]  && return 0
  [ `pgrep -n $1` ] && return 1 || return 0
}

case $1 in
start)
/usr/bin/emergence-kernel &
;;
stop)
killall -9 'emergence-kernel'
;;
restart)
killall -9 'emergence-kernel'
sh /usr/bin/emergence-kernel &
;;
restartifdead)
check_process "emergence-kernel"
[ $? -eq 0 ] && echo "not running, restarting..." && `/etc/init.d/emergence-kernel start -i > /dev/null`
;;
status)
ps -ef |grep emergence-kernel|grep -vw grep
;;
esac
exit 0