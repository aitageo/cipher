#!/bin/bash
#por aitageo
#programa para cifrar o descifrar archivos con gpg

#Paleta de Colores
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"


declare eliminar_cache_gpg=$(gpg-connect-agent reloadagent /bye)


trap interumpir INT

function interumpir(){
  echo -e "${redColour}\n[*]Saliendo..\n${endColour}"
  exit 0
  tput civis
}
tput cnorm 

function cifrar_archivo(){
    echo -e  "${blueColour}Haz escogido cifrar el archivo${endColour}"
    read -p  "ingrese archivo: "  archivo
    if [ -f $archivo ];then
       gpg -c $archivo
       rm -rf $archivo
       echo -e "${blueColour}archivo cifrado y original borrado${endColour}"
    else
       echo -e "${redColour}archivo no existe${endColour}"
   
fi
}

function descifrar_archivo(){
     echo -e "${blueColour}Haz escogido descifrar el archivo${endColour}"
     $eliminar_cache_gpg 2>/dev/null
     read -p "ingrese archivo con extension gpg: " archivo
     if [ -f $archivo ];then
         gpg -d $archivo > archivo_recuperado.txt 2>/dev/null 
         rm -rf $archivo
         echo -e  "${blueColour}archivo descifrado y recuperado original${endColour}"
      else
         echo -e  "${redColour}archivo no existe${endColour}"
    
fi
}


while : 
do
echo -e  "${yellowColour}_____________________________${endColour}"
echo -e  "${yellowColour}_________MENU PRINCIPAL______${endColour}"
echo -e  "${yellowColour}1: Cifrar archivo${endColour}"
echo -e  "${yellowColour}2: Descifrar archivo${endColour}"
echo -e  "${redColour}control C para salir${endColour}"

read -p "ingrese opcion (1) o (2): " opcion

case $opcion in
  1) cifrar_archivo
  ;;
  2) descifrar_archivo
  ;;
esac
done
