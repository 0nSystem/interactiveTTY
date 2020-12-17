# interactiveTTY

## Dependencias

**tmux**

*Instalacion: sudo apt install tmux -y*


## Como funciona

**./interactiveTTY.sh [port_value]**


*Una vez iniciado es script pasando un puerto para la escucha de netcat, te indicara que netcat esta activado, apartir de ahi tienes un contador que llega hasta 10 para que se una el cliente,
una vez acabo ese tipo se inyectaran los comandos de tratamiento de tty, **no hace comprobaciones de si se unio un cliente***
