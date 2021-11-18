#! /bin/sh

for var in $(env); 
do
if [[ $var == ETORO* ]]
then
    echo $var
fi
done