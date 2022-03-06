#!/bin/bash
if [[ $1 == "" ]]; then
while true
do
uno=`systemctl status cups | grep "cups.path"`
        if [[ $uno ]]; then
            echo "El servicio ya esta instalado, le dejo varias opciones."
                echo "1. Ver estado del Servicio Cups"
                echo "2. Iniciar el Servicio Cups"
                echo "3. Parar el Servicio Cups"
                echo "4. Reiniciar el Servicio Cups" 
                echo "5. Abrir el navegador con la configuracion de Cups"
                echo "6. Mostrar los Logs de acceso de cups"
                echo "7. Mostrar los logs de error de cups"
                echo "8. Desintalar el Servicio Cups"
                echo "9. Salir"
                read -p "Digame la opcion que quieres utilizar " orden2
                case $orden2 in
                        1)
                                echo "Estado del servicio:"
                                dos=`systemctl status cups | grep "inactive (dead)"`
                                if [[  $dos ]]; then
                                        echo " "
                                        echo "Servicio Parado"
                                        echo " "
                                else
                                        echo " "
                                        echo "Servicio Activo"
                                        echo " "
				fi
				systemctl status cups
                        ;;
			2)
                                tres=`systemctl status cups | grep "active (running)"`
				if [[ $tres ]]; then
					echo "El servicio ya esta iniciado"
				else
	                           	echo "Iniciando Servicio"
                                	sudo systemctl start cups.service
					echo " "
					echo "Servicio Iniciado"
					echo " "
				fi
                        ;;
                        3)
                                cuatro=`systemctl status cups | grep "inactive (dead)"`
                                if [[ $cuatro ]]; then
                                        echo "El servicio ya esta parado"
                                else
                                        echo "Parando Servicio"
                                        sudo systemctl stop cups.service
                                        echo " "
                                        echo "Servicio Parado"
                                        echo " "
                                fi
                        ;;
                        4)
                                echo "Reiniciando Servicio"
                                sudo /etc/init.d/cups restart
                        ;;
                        5)
                                ip=`hostname -I | cut -d " " -f1`
                                echo "Se abre el navegador para configurar el Servicio"
                                firefox $ip:631
                        ;;
                        6)
                                echo "LOGS DE ACCESO:"
                                cat /var/log/cups/access_log
                        ;;
                        7)
                                echo "LOGS DE ERROR:"
                                cat /var/log/cups/error_log
                        ;;
                        8)
                                sudo apt-get remove cups
                                sudo apt-get autoremove
                                echo "Servicio Desinstalado"
                                break
                        ;;
                        9)
                                break
                        ;;
                        *)
                                echo "Elija otra opcion, esa no muestra nada"
                        ;;
				 esac
        else
                echo "Servicio no instalado"
                read -p "¿Desea Instalarlo? Si(s)/NO(n) " orden
                if [[ $orden == "s" ]]; then
                        usuario=`whoami`
                        sudo apt-update 
                        sudo apt upgrade
                        sudo apt install cups
                        sudo usermod -a -G lpadmin $usuario
                        sudo cupsctl --remote-any
                        sudo /etc/init.d/cups restart
                        sudo apt-get install cups-pdf
                        echo "Servicio Instalado"
                else
                        break
                fi
        fi
done
elif [[ $1 == "instalar" ]]; then
	uno=`systemctl status cups | grep "cups.path"`
	if [[ $uno ]]; then
		echo "servicio instalado"
	else
		echo "Servicio no instalado"
                read -p "¿Desea Instalarlo? Si(s)/NO(n) " orden
                if [[ $orden == "s" ]]; then
                        usuario=`whoami`
                        sudo apt-update 
                        sudo apt upgrade
                        sudo apt install cups
                        sudo usermod -a -G lpadmin $usuario
                        sudo cupsctl --remote-any
                        sudo /etc/init.d/cups restart
                        sudo apt-get install cups-pdf
                        echo "Servicio Instalado"
                else
                        echo "El servicio no se intalara"
		  fi
	fi
elif [[ $1 == "estado" ]]; then
	echo "Estado del servicio:"
        dos=`systemctl status cups | grep "inactive (dead)"`
        if [[  $dos ]]; then
	        echo " "
                echo "Servicio Parado"
                echo " "
        else
        	echo " "
                echo "Servicio Activo"
                echo " "
        fi
        systemctl status cups
elif [[ $1 == "iniciar" ]]; then
	tres=`systemctl status cups | grep "active (running)"`
        if [[ $tres ]]; then
        	echo "El servicio ya esta iniciado"
        else
                echo "Iniciando Servicio"
                sudo systemctl start cups.service
                echo " "
                echo "Servicio Iniciado"
                echo " "
        fi
elif [[ $1 == "parar" ]]; then
	cuatro=`systemctl status cups | grep "inactive (dead)"`
	if [[ $cuatro ]]; then
		echo "El servicio ya esta parado"
	else
		echo "Parando Servicio"
                sudo systemctl stop cups.service
                echo " "
                echo "Servicio Parado"
                echo " "
	fi
elif [[ $1 == "desinstalar" ]]; then
	  uno=`systemctl status cups | grep "cups.path"`
        if [[ $uno ]]; then
                echo "Desinstalando servicio"
               	sudo apt-get remove cups
                sudo apt-get autoremove
                echo "Servicio Desinstalado"
        else
                echo "El servicio no estaba instalado"
        fi
fi
