#!/bin/bash
#
#script backup-micro.sh
# Version : 1.0
#Para generar respaldos de una carpte compartida en windows y el respaldo se guarda en un servidor linux
#Autor : Ing. Jorge Navarrete
#mail : jorge_n@web.de
#Fecha : 2020-10-17

#script backup-micro.sh
#Para generar respaldos de una carpte compartida en windows y el respaldo se guarda en un servidor linux 


#===========================================================================
PATH=/bin:/usr/bin:/usr/sbin/
#===========================================================================
#VARIABLES
NOMBREBACKUP=micro-windows-
DIRECTORIO1=home/windowsshare/COMP09/
servermicro="192.168.0.5"

#===========================================================================i
FECHAINICIO=`date +%Y-%m-%d`
CADENALASTDAY="`echo $FECHAINICIO | sed 's/:/ /g'`" 
ARCHIVO1=`echo $NOMBREBACKUP`"_"`echo $CADENALASTDAY`".tar.bz2"


# si existe el la carpeta montada (windows)  realiza el respalgdo en el server linux
if mountpoint -q /home/windowsshare
then
    echo ""  
    tar -czpvf /home/usuariotl/micro-data/$ARCHIVO1 /$DIRECTORIO1
    echo "tar realizado"	
# si caeprte no montada  envia mensaje de erro a telegram
else
    echo "not mounted" 
     TOKEN="569774679:AAEl8uSwPNDzHwM_MCCR1-iXi4C6zLGeoqU"  
     ID="152054272" 
     IDdiego="966225514" 
     MENSAJE="Unidad de red de MICROSOFT no montada!!! backup no ejecutado" 
     MENSAJEIP="Servidor no alcanzable!!" 
     URL="https://api.telegram.org/bot$TOKEN/sendMessage" 
     curl -s -X POST $URL -d chat_id=$ID -d text="$MENSAJE"  > /dev/null 
     curl -s -X POST $URL -d chat_id=$IDdiego -d text="$MENSAJE"  > /dev/null 

#si no se tiene ping al servidor se envia otro mensaje a telegram
	ping -c1 -W1 -q $servermicro &>/dev/null && echo '' || curl -s -X POST $URL -d chat_id=$ID -d text="$MENSAJEIP"  > /dev/null
#     /usr/bin/mount /home/windowsshare/ 
fi
