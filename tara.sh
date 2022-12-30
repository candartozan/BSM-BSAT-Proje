#!/bin/bash

dir="/home/candar/odev-test"


db_host="localhost"
db_user="candar"
db_name="VeriTabani"

snapshot=$(ls $dir)

while :
do
	new_snapshot=$(ls $dir)

	changes=$(diff <(echo "$snapshot") <(echo "$new_snapshot"))

	if [ "$changes" != "" ]
	then
		psql -h $db_host -U $db_user -d $db_name <<EOF
		INSERT INTO changes (file) VALUES ('$changes');
EOF
	snapshot=$new_snapshot
	fi

	sleep 10
done
