#!/bin/bash

result=0
while read -r line; do 
	echo $line;
	line=`awk -v str=$line 'BEGIN {
	sub(/one/, "o1e", str);
	sub(/two/, "t2o", str);
	sub(/three/, "t3e", str);
	sub(/four/, "f4r", str);
	sub(/five/, "f5e", str);
	sub(/six/, "s6x", str);
	sub(/seven/, "s7n", str);
	sub(/eight/, "e8t", str);
	sub(/nine/, "n9e", str);
		print str}'`;
	line=`awk -v str=$line 'BEGIN {
	sub(/one/, "o1e", str);
	sub(/two/, "t2o", str);
	sub(/three/, "t3e", str);
	sub(/four/, "f4r", str);
	sub(/five/, "f5e", str);
	sub(/six/, "s6x", str);
	sub(/seven/, "s7n", str);
	sub(/eight/, "e8t", str);
	sub(/nine/, "n9e", str);
		print str}'`;
	line=`awk -v str=$line 'BEGIN {
	sub(/one/, "o1e", str);
	sub(/two/, "t2o", str);
	sub(/three/, "t3e", str);
	sub(/four/, "f4r", str);
	sub(/five/, "f5e", str);
	sub(/six/, "s6x", str);
	sub(/seven/, "s7n", str);
	sub(/eight/, "e8t", str);
	sub(/nine/, "n9e", str);
		print str}'`;
	line=`awk -v str=$line 'BEGIN {
	sub(/one/, "o1e", str);
	sub(/two/, "t2o", str);
	sub(/three/, "t3e", str);
	sub(/four/, "f4r", str);
	sub(/five/, "f5e", str);
	sub(/six/, "s6x", str);
	sub(/seven/, "s7n", str);
	sub(/eight/, "e8t", str);
	sub(/nine/, "n9e", str);
		print str}'`;
	line=`awk -v str=$line 'BEGIN {
	sub(/one/, "o1e", str);
	sub(/two/, "t2o", str);
	sub(/three/, "t3e", str);
	sub(/four/, "f4r", str);
	sub(/five/, "f5e", str);
	sub(/six/, "s6x", str);
	sub(/seven/, "s7n", str);
	sub(/eight/, "e8t", str);
	sub(/nine/, "n9e", str);
		print str}'`;
	line=`awk -v str=$line 'BEGIN {
	sub(/one/, "o1e", str);
	sub(/two/, "t2o", str);
	sub(/three/, "t3e", str);
	sub(/four/, "f4r", str);
	sub(/five/, "f5e", str);
	sub(/six/, "s6x", str);
	sub(/seven/, "s7n", str);
	sub(/eight/, "e8t", str);
	sub(/nine/, "n9e", str);
		print str}'`;
	line=`awk -v str=$line 'BEGIN {
	sub(/one/, "o1e", str);
	sub(/two/, "t2o", str);
	sub(/three/, "t3e", str);
	sub(/four/, "f4r", str);
	sub(/five/, "f5e", str);
	sub(/six/, "s6x", str);
	sub(/seven/, "s7n", str);
	sub(/eight/, "e8t", str);
	sub(/nine/, "n9e", str);
		print str}'`;
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
