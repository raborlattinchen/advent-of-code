#!/bin/bash

result=0
while read -r line; do 
	echo $line; 
	read -a ARRAY <<< $(echo $line | sed 's/./& /g');
	echo ${ARRAY[@]};
	getnumbers=`echo ${ARRAY[@]} | tr -d -c 0-9`;
	read -a ARRAY2 <<< $(echo $getnumbers | sed 's/./& /g');
	echo ${ARRAY2[@]};
	endnumber=`echo ${ARRAY2[0]}${ARRAY2[${#ARRAY2[@]}-1]}`;	
	echo $endnumber;
	result=$(( $result + $endnumber ));
	printf "$result \n";
done < input.data
