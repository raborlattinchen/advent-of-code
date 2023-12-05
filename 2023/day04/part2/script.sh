#!/bin/bash

# check if number exists in list
function exists_in_list() {
	LIST=$1;
	DELIMITER=$2;
	VALUE=$3;
	echo $LIST | tr "$DELIMITER" '\n' | grep -F -q -x "$VALUE";
}

numlines=`wc -l input.data`;
result=0;
endresult=0;
while read -r line; do 
	# echo $line;
	# split input
	card=`echo $line | awk -F"[:|]" '{print $1}'`;
	echo $card;
	cardnr=`echo $card | awk '{print $2}'`;
	numbers=`echo $line | awk -F"[:|]" '{print $2}'`;
	winnum=`echo $line | awk -F"[:|]" '{print $3}'`;
		hit=0;
		# interate over numbers in list
		for n in `echo $numbers | awk '{print $0}'`; do
			# check if number exists in list
			if exists_in_list "$winnum" " " $n; then
				# echo "$n is on the list of $card";
				# count number of hits each time a card contains a number that is on the list
				hit=$(( $hit + 1 ));
				# echo "$card has $hit hits";
			# else
				# echo "$n is not on the list";
			fi
		done
		newcard=$(( $hit * $repgame ));
		echo $newcard;
		# repeate games
		for rg in $(seq $repgame); do
			# number of hits = number of new cards
			# echo "you win $hit new cards";
			# how many new cards?
			result=$(( $hit + $result ));
			# only look at games that win new cards
			if [ $hit -gt 0 ]; then
				for i in $(seq 1 $hit); do
					# which game wins another card
					newgame=$(( $cardnr + $i ));
					# echo "you win a card for game $newgame. repeat game $newgame $repgame times";
				done
			fi
			# repeat game $newcard once
			repgame=$(( $repgame + 1 ));
		done
	echo $result;
done < input.data
endresult=$(( $result + $cardnr ));
echo $endresult;
