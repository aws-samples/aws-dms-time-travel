#! /bin/bash

echo "Connecting to the target database"
mysql -h${TGTHOST} -P ${TGTDBPORT} -u${TGTDBUSER} -D ${TGTDB} -p${TGTDBPASSWORD}

