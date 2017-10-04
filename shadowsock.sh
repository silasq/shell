# install
yum -y install python-pip
pip install --upgrade pip
pip install shadowsocks

# build config file
echo '{' >> /etc/ss.conf
echo '"server":"0.0.0.0",' >> /etc/ss.conf
echo '"server_port":1234,' >> /etc/ss.conf
echo '"local_address":"127.0.0.1",' >> /etc/ss.conf
echo '"local_port":1080,' >> /etc/ss.conf
echo '"password":"Silasss917",' >> /etc/ss.conf
echo '"timeout":600,' >> /etc/ss.conf
echo '"method":"RC4-MD5"' >> /etc/ss.conf
echo '}' >> /etc/ss.conf

# config auto start on boot
echo "ssserver -c /etc/ss.conf -d start" >> /etc/rc.d/rc.local
chmod +x /etc/rc.d/rc.local

# start service
ssserver -c /etc/ss.conf -d start