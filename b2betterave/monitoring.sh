#! /bin/zsh

ARCH="$(uname -s) version $(uname -r)"
PCPU=$(grep '^physical id' /proc/cpuinfo | uniq | wc -l)
VCPU=$(grep '^processor'   /proc/cpuinfo | uniq | wc -l)

TOTARAM=$(free -m | grep Mem | awk '{print $2}')
USEDRAM=$(free -m | grep Mem | awk '{print $3}')
PERCRAM=$(free -m | grep Mem | awk '{printf ("%.2f"), $3/$2*100}')

TOTADISK=$(df -BG --total | grep total | awk '{print $2}')
USEDDISK=$(df -BG --total | grep total | awk '{print $3}')
PERCDISK=$(df -BG --total | grep total | awk '{print $5}')

CPUSED=$(top -bn1 | grep %Cpu | awk '{print $2 + $4 + $6}')
LAST_BOOT=$(who -b | awk '{print($3 " " $4)}')
LVM=$(if [ $(lsblk | grep lvm | wc -l) -eq 0 ]; then echo no; else echo yes; fi)

TCP=$(grep TCP /proc/net/sockstat | awk '{print $3}')
USERS_LOG=$(who | wc -l)
USERS_UNIQ=$(users | tr ' ' '\n' | uniq | wc -l)
IP_ADDR=$(hostname -I | awk '{print $1}')
MAC_ADDR=$(ip link show | grep link/ether | awk '{print $2}')
SUDO_LOG=$(grep COMMAND /var/log/sudo/sudo.log | wc -l)

ASCII=$(figlet Born2Betterave)

wall "
$ASCII

Architecture			:	$ARCH
Nb of physical processors	:	$PCPU
Nb of virtual processors	:	$VCPU
RAM  usage			:	${USEDRAM}/${TOTARAM} MiB = ${PERCRAM}%	
DISK usage			:	${USEDDISK}/${TOTADISK} GiB = ${PERCDISK}%
CPU  usage			:	${CPUSED}%
Last boot			:	${LAST_BOOT}
LVM				:	${LVM}
TCP Connections			:	$TCP in use
Users logged			:	$USERS_LOG
Unique Users			:	$USERS_UNIQ
IPv4 -- MAC address		:	$IP_ADDR -- $MAC_ADDR
Sudo				:	$SUDO_LOG commands used
"
