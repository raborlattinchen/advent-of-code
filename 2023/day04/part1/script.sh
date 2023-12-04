#!/bin/bash

# check if number exists in list
function exists_in_list() {
	LIST=$1;
	DELIMITER=$2;
	VALUE=$3;
	echo $LIST | tr "$DELIMITER" '\n' | grep -F -q -x "$VALUE";
}

results=0;
while read -r line; do 
	echo $line;
	# split input
	card=`echo $line | awk -F"[:|]" '{print $1}'`;
	numbers=`echo $line | awk -F"[:|]" '{print $2}'`;
	echo $numbers;
	winnum=`echo $line | awk -F"[:|]" '{print $3}'`;
	hit=0;
	# interate over numbers in list
	for n in `echo $numbers | awk '{print $0}'`; do
		echo $n;
		# check if number exists in list
		if exists_in_list "$winnum" " " $n; then
			echo "$n is on the list of $card";
			# count number of hits each time a card contains a number that is on the list
			hit=$(( $hit + 1 ));
			echo "$card has $hit hits";
		else
			echo "$n is not on the list";
		fi
	done
	# first hit gives 1 point, second hit gives 2 point, third hit gives 4 points, fourth hit 8
	# 2^0, 2^1, 2^2, 2^3
	exponent=$(( $hit - 1 ));
	point=0;
	# calculate points for each card
	if [ $exponent -ge 0 ]; then
		point=$(( 2**$exponent ));
	fi
	echo "$card gives $point points";
	# add up points
	result=$(( $result + $point ));
	echo $result;
done < input.data
