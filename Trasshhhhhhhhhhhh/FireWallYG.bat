netsh advfirewall firewall set rule name="YuGI" new enable=yes
timeout /t 2
netsh advfirewall firewall set rule name="YuGI" new enable=no
timeout /t 1