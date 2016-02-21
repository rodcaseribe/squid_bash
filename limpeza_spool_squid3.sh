
#!/bin/bash
/etc/init.d/squid3 stop && rm -rf /var/spool/squid3/* && squid3 -z && /etc/init.d/squid3 start
