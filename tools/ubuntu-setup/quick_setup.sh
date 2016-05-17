#!/bin/bash -e

set -e

curl -fsSL https://get.docker.com/gpg | sudo apt-key add -

sudo add-apt-repository ppa:couchdb/stable -y
sudo apt-get update --fix-missing
sudo apt-get install git couchdb -y
sudo sed -i -- "s/;bind_address = 127.0.0.1/bind_address = 0.0.0.0/g" /etc/couchdb/local.ini
sudo service couchdb restart

export DB_USER=iamkyloren
export DB_PASSWORD=ILoveYouGrandPa
export DB_HOST=$(ip route get 8.8.8.8 | awk '{print $NF; exit}')
export DB_PORT=5984

curl -X PUT http://$DB_HOST:$DB_PORT/_config/admins/$DB_USER -d '"'"$DB_PASSWORD"'"'
curl -X GET http://$DB_USER:$DB_PASSWORD@$DB_HOST:$DB_PORT/_config
cp template-couchdb-local.env couchdb-local.env
sed -i -- "s/OPEN_WHISK_DB_PROTOCOL=/OPEN_WHISK_DB_PROTOCOL=http/g" couchdb-local.env
sed -i -- "s/OPEN_WHISK_DB_HOST=/OPEN_WHISK_DB_HOST=$DB_HOST/g" couchdb-local.env
sed -i -- "s/OPEN_WHISK_DB_PORT=/OPEN_WHISK_DB_PORT=$DB_PORT/g" couchdb-local.env
sed -i -- "s/OPEN_WHISK_DB_USERNAME=/OPEN_WHISK_DB_USERNAME=$DB_USER/g" couchdb-local.env
sed -i -- "s/OPEN_WHISK_DB_PASSWORD=/OPEN_WHISK_DB_PASSWORD=$DB_PASSWORD/g" couchdb-local.env
source all.sh
