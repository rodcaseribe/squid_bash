#!/bin/bash

echo "Content-type: text/html"
echo ""
echo '<html>'
echo '<head>'
echo '<meta charset="UTF-8">'
echo '<title>Liberação de Usuários e Senhas no Squid</title>'
echo '<link rel="stylesheet" href="css.css" type="text/css">'
echo '</head>'
echo '<div align="center"><h1 id="section1" class="filter-drop-shadow" >Liberação de Usuários no Squid Proxy:</h1>'
#echo '<pre align=left class="filter-drop-shadow"><h5 style=color:white;>'
read POST
CODE=$(echo $POST | cut -d '&' -f 1 | cut -d '=' -f 2)
echo '<form method="POST">'
echo '<textarea name="code" rows="30" cols="90"></textarea>'
echo '<br>'
echo '<input type="submit" name="submit" value="Enviar">'
echo '</form></div>'
echo '<pre>'
echo $CODE > /var/www/html/cgi/codigo_encodado.txt
#cat codigo_encodado.txt
php decoder.php > codigo_desencodado.txt
cat codigo_desencodado.txt > usuarios_senhas.txt
echo '</pre>'

###CONTANDO AS LINHAS e jogando na Variável X#######################

x=$(wc -l usuarios_senhas.txt | cut -d ' ' -f 1)

####################################################################

###########Laço for incrementado na variável de LINHAS##############

for ((z=1;z<=x;z++))
do

########Seprando a linhas pela variavel e fazendo o corte em :######
########Armazenando em somente_usuario

somente_usuario=$(sed -n $z' p;' usuarios_senhas.txt | cut -d : -f 1)

########Seprando a linha pela variável e fazendo o corte na 2 fileira
########Armazenando em somente_senha################################

somente_senha=$(sed -n $z' p;' usuarios_senhas.txt | cut -d : -f 2)

######Jogando as 2 variáveis em htpasswd#############################

htpasswd -b /etc/squid3/autenticacao "$somente_usuario" "$somente_senha"
done
