
#! /bin/sh
# Fazendo Backup dos logs atuais
#/usr/sbin/sarg-reports today #relatorio do sarg
tar -zcvf /mnt/secundario/backup_squid/log-`date +%d.%m.%y-%H:%M`.tar.gz /var/log
# Acessando o diretório de logs
cd /var/log
# Procura todos os arquivos no /var/log e executa a limpeza
for l in `find . -type f -exec ls {} \;`; do
        echo -n >$l &>/dev/null
done
# Remove arquivos de backup de logs com mais de 3 dias de criação
#find /home/backup_var/ -name "*.tar.gz" -ctime +3 -exec rm -rf {} \;
