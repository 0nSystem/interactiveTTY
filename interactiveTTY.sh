#!/bin/bash

#Author OnSystem
#License GPL
#Este script esta orientado a la enseñanza y ha agilizar la productividad
#Usalo de forma etica

red="\e[31m"
cyan="\e[36m"
purple="\e[35m"
reset="\e[0m"

actualWindowID=$(tmux list-windows | grep '*' | cut -d ':' -f 1)
port=$1
trap ctrl_c INT

ctrl_c()
{
	tput cnorm
	exit 0
}

banner()
{
    echo -e "${red}
    #
   # #   #    # #####  ####  #    #   ##   ##### # ###### ######
  #   #  #    #   #   #    # ##  ##  #  #    #   #     #  #
 #     # #    #   #   #    # # ## # #    #   #   #    #   #####
 ####### #    #   #   #    # #    # ######   #   #   #    #
 #     # #    #   #   #    # #    # #    #   #   #  #     #
 #     #  ####    #    ####  #    # #    #   #   # ###### ######
${cyan}
 ###                                                                     ####### ####### #     #
  #  #    # ##### ###### #####    ##    ####  ##### # #    # ######         #       #     #   #
  #  ##   #   #   #      #    #  #  #  #    #   #   # #    # #              #       #      # #
  #  # #  #   #   #####  #    # #    # #        #   # #    # #####   ####   #       #       #
  #  #  # #   #   #      #####  ###### #        #   # #    # #              #       #       #
  #  #   ##   #   #      #   #  #    # #    #   #   #  #  #  #              #       #       #
 ### #    #   #   ###### #    # #    #  ####    #   #   ##   ######         #       #       #
${purple}
 ######                                                   #####
 #     # ###### #    # ###### #####   ####  ######       #     # #    # ###### #      #
 #     # #      #    # #      #    # #      #            #       #    # #      #      #
 ######  #####  #    # #####  #    #  ####  #####  #####  #####  ###### #####  #      #
 #   #   #      #    # #      #####       # #                  # #    # #      #      #
 #    #  #       #  #  #      #   #  #    # #            #     # #    # #      #      #
 #     # ######   ##   ###### #    #  ####  ######        #####  #    # ###### ###### ######
${reset}"
}

executeprogram()
{
    #primero creamos una ventana de tmux que tendra un panel
    tmux new-window -n "reverse_shell"
	#Vuelvo a la ventana desde la que empezamos
	tmux select-window -t $actualWindowID
    #$window obtiene el numero de la ventana
    windowReverse=$(tmux list-windows | grep "reverse_shell" | cut -d ':' -f 1)
    #Ya que solo tendra un panel es cero, porque esta recien creado
    panel="$windowReverse.0"

    tmux send-keys -t $panel "bash" Enter
    tmux send-keys -t $panel "nc -lp $port" Enter
    #Un tiempo de espera para que le de tiempo al usuario a conectarse sino fallara
	echo -e "\n\n\tNetcat conectado activa tu cliente para que se conecte\n"
	for i in {0..10}
	do
		echo -ne "${cyan}\t\t\tEsperando"
		for a in {0..5}
		do
			echo -ne "${red}.";sleep 0.1
		done
		echo -e "${purple}$i${reset}"
		sleep 0.3
	done
    tmux send-keys -t $panel 'script /dev/null -c bash' Enter
    #Poner en segundo plano
    tmux send-keys -t $panel C-z
    tmux send-keys -t $panel 'stty raw -echo' Enter
    tmux send-keys -t $panel "fg" Enter
    tmux send-keys -t $panel "export TERM=$TERM" Enter
    tmux send-keys -t $panel "export SHELL=bash" Enter
	tmux send-keys -t $panel "clear" Enter
tmux select-window -t $windowReverse
}


if [[ $port != "" ]]
then
	tput civis
	banner
	executeprogram
	tput cnorm
else
	echo -e "$red Deberias escribir un parametro especificando el puerto"
fi
