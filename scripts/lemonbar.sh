#!/bin/bash

Clock(){
    DATETIME=$(date "+%a %-d %b, %-l:%M %p")
    echo -e -n "${DATETIME}"
}

User(){
    echo -n $USER@$(hostname)
}

Uptime(){
    m=$(uptime -p)
    echo -n ${m:2}
}

Cpu(){
    c=$(top -bn1 | grep "Cpu(s)" | \
           sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | \
           awk '{print 100 - $1}')
    line="    "
    printf "${line:${#c}}""%s %s" $c%


}

Memory(){
     mem=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
     memp=${mem:0:-2}%
     line="       "
     printf "${line:${#memp}}""%s %s" $memp
}
 
while true; do
	echo -e "[$(User)] [$(Uptime)] [$(Cpu)] [$(Memory)] [$(Clock)]"
	#Uncomment the sleep command here if $(Network) isn't active otherwise the sleep command is provided in it
	sleep 1s
done
