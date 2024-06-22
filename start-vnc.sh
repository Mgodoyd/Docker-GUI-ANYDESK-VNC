#!/bin/bash 

echo  'Actualizando el archivo /etc/hosts...'
 HOSTNAME=$(hostname) 
echo  "127.0.1.1\t $HOSTNAME " >> /etc/hosts 

echo  "Iniciando el servidor VNC en $RESOLUTION .. ."
 vncserver - matar :1 || true
 vncserver -geometry $RESOLUTION & 

echo  "El servidor VNC se inició en $RESOLUTION ! ^-^" 

echo  "Iniciando tail -f /dev/null..." 
tail -f /dev/null
