# change root password
echo "passwd:"
read pass
echo $pass|passwd --stdin root

# permit root login
sed -i "s/PermitRootLogin no/PermitRootLogin yes/" /etc/ssh/sshd_config
sed -i "s/PasswordAuthentication no/PasswordAuthentication yes/" /etc/ssh/sshd_config
sed -i "s/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/" /etc/ssh/sshd_config
service sshd restart