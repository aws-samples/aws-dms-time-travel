#! /bin/bash

export PGPASSWORD=$SRCDBPASSWORD
psql -h${SRCHOST} -p ${SRCPORT} -U${SRCDBUSER} -d ${SRCDB}

