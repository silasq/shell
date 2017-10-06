#! /bin/sh

# install base software
yum -y install wget
yum -y install golang
yum -y install unzip


# config golang
echo "export GOROOT=/usr/lib/golang" >> /etc/profile
echo "export GOPATH=/home/user1/gopackage" >> /etc/profile
echo "export PATH=$PATH:$GOROOT/bin:$GOPATH/bin" >> /etc/profile
source /etc/profile
mkdir /root/gopackage

# download code
cd /tmp
wget https://github.com/leanote/leanote-all/archive/master.zip
unzip master.zip
mv /tmp/src /root/gopackage/  
cd /root/gopackage/src

# install revel
go install github.com/revel/cmd/revel

# install mongodb
cd /root
wget https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-3.0.1.tgz
tar -xzvf mongodb-linux-x86_64-3.0.1.tgz
echo "export PATH=$PATH:/home/user1/mongodb-linux-x86_64-3.0.1/bin"  >> /etc/profile
source /etc/profile

mkdir /root/data

# import database
mongorestore -h localhost -d leanote --dir /root/gopackage/src/github.com/leanote/leanote/mongodb_backup/leanote_install_data

# add database user
mongod --dbpath /root/data
mongo
use leanote;
db.createUser({
    user: 'root',
    pwd: 'Silasdbs917',
    roles: [{role: 'dbOwner', db: 'leanote'}]
});
exit

# start mongodb deamon
mongod --dbpath=/root/data --auth --fork --logpath=/root/data/mongodb.log

# config leanote
sed -i "s/db.username=/db.username=root/" /root/gopackage/src/github.com/leanote/leanote/conf/app.conf
sed -i "s/db.password=/db.password=Silasdbs917/" /root/gopackage/src/github.com/leanote/leanote/conf/app.conf
sed -i "s/V85ZzBeTnzpsHyjQX/V85ZzBeTnzpsHywLX/" /root/gopackage/src/github.com/leanote/leanote/conf/app.conf

# start leanote
revel run github.com/leanote/leanote 




