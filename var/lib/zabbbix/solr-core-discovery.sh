#!/bin/bash

CORE_STATUS_URL="http://localhost:9091/solr/admin/cores?action=STATUS"

xml=`curl -s ${CORE_STATUS_URL}`

cores=`echo ${xml} | tr -s "</" "\n" | grep "str name=\"name\"" | sed  "s/str name=\"name\">//"`

#echo $cores
echo "{"
echo " \"data\": [ "

first="true"
while read -r core; do
  if [ ${first} == "true" ]; then
      first="false"
     else
      echo ","
  fi
 echo "{ \"{#CORENAME}\": \"$core\" }"
done <<< "$cores"

echo "  ]"
echo "}"
