#! /bin/bash

if [ -z "$1" ]; then
    chain=kovan
else
    chain=$1
fi
echo $chain
json=$(curl https://changelog.makerdao.com/releases/${chain}/active/contracts.json -L 2> /dev/null)
if [[ $json == {* ]]
   then
       lines=$(echo $json | sed 's/{ "/export~/' | sed 's/": "/=/g' | sed 's/", "/ export~/g' | sed 's/" }//')
       for line in $lines; do
           export=$(echo $line | sed 's/~/ /')
           echo $export
           eval $export
       done
    else
        echo "${json}"
        echo "error"
   fi
