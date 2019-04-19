#!/bin/bash

#导出sql脚本
while read FULLNAME
do
DB=${FULLNAME%%.*}
echo ${DB}
TABLE=${FULLNAME##*.}
echo ${TABLE}
echo "use ${DB};" > ./${FULLNAME}.sql
hive -e "use ${DB}; show create table ${TABLE};" | grep -v "^WARN:"  >> ./${FULLNAME}.sql
sed -i 's/hdfs:\/\/aicluster\/user/hdfs:\/\/nameservice1\/user/' ./${FULLNAME}.sql
done < ./table.txt
