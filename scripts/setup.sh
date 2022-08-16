#! /bin/bash

pip3 install mysql-connector-python
sudo yum update -y
sudo yum install -y autoconf readline-devel zlib-devel jq
sudo yum install -y gcc jemalloc-devel openssl-devel tcl tcl-devel clang wget
wget https://ftp.postgresql.org/pub/source/v12.5/postgresql-12.5.tar.gz
tar -xzf postgresql-12.5.tar.gz
cd postgresql-12.5
autoconf
./configure
make -j 4 all
sudo make install

export REGION=`aws configure get region`

echo "export SRCDBUSER=\`aws secretsmanager get-secret-value  --secret-id \"/dms-source/dbsecret\" --region $REGION --query 'SecretString' --output text | jq -r '.\"username\"'\`" >> ~/.bashrc
echo "export SRCPORT=\`aws secretsmanager get-secret-value  --secret-id \"/dms-source/dbsecret\" --region $REGION --query 'SecretString' --output text | jq -r '.\"port\"'\`" >> ~/.bashrc
echo "export SRCDB=\`aws secretsmanager get-secret-value  --secret-id \"/dms-source/dbsecret\" --region $REGION --query 'SecretString' --output text | jq -r '.\"dbname\"'\`" >> ~/.bashrc
echo "export SRCHOST=\`aws secretsmanager get-secret-value  --secret-id \"/dms-source/dbsecret\" --region $REGION --query 'SecretString' --output text | jq -r '.\"host\"'\`" >> ~/.bashrc
echo "export SRCDBPASSWORD=\`aws secretsmanager get-secret-value  --secret-id \"/dms-source/dbsecret\" --region $REGION --query 'SecretString' --output text | jq -r '.\"password\"'\`" >> ~/.bashrc

echo "export TGTDBUSER=\`aws secretsmanager get-secret-value  --secret-id \"/dms-target/dbsecret\" --region $REGION --query 'SecretString' --output text | jq -r '.\"username\"'\`" >> ~/.bashrc
echo "export TGTDBPORT=\`aws secretsmanager get-secret-value  --secret-id \"/dms-target/dbsecret\" --region $REGION --query 'SecretString' --output text | jq -r '.\"port\"'\`" >> ~/.bashrc
echo "export TGTDB=\`aws secretsmanager get-secret-value  --secret-id \"/dms-target/dbsecret\" --region $REGION --query 'SecretString' --output text | jq -r '.\"dbname\"'\`" >> ~/.bashrc
echo "export TGTHOST=\`aws secretsmanager get-secret-value  --secret-id \"/dms-target/dbsecret\" --region $REGION --query 'SecretString' --output text | jq -r '.\"host\"'\`" >> ~/.bashrc
echo "export TGTDBPASSWORD=\`aws secretsmanager get-secret-value  --secret-id \"/dms-target/dbsecret\" --region $REGION --query 'SecretString' --output text | jq -r '.\"password\"'\`" >> ~/.bashrc

echo "export PATH=\"$PATH:/usr/local/pgsql/bin\"" >> ~/.bashrc

