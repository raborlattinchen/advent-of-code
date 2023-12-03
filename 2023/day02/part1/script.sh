#!/bin/bash

result=0;
while read -r line; do 
	echo $line;
	# number of bag grabs = number of semicolons
	grabnum=$(( `echo $line | sed 's/[^;]//g' | awk '{print length}'` + 1 ));
	# printf "number of bag grabs: $grabnum \n";
	countgreen=0;
	countblue=0;
	countred=0;
	limitred=12;
	limitgreen=13;
	limitblue=14;
	largestred=0;
	largestgreen=0;
	largestblue=0;
	# print each grab
	for grabseq in $(seq 1 $grabnum); do
		grab=`echo $line | awk -F"[:;]" -v grabseq=$grabseq '{split($0,array); print array[grabseq+1]}'`; 
		# printf "grab nr. $grabseq : $grab \n";
		# number of different cubes = number of colons
		cubenum=$(( `echo $grab | sed 's/[^,]//g' | awk '{print length}'` + 1));
		# printf "number of different cubes: $cubenum \n";
		# print different cubes
		for cubeseq in $(seq 1 $cubenum); do
			cube=`echo $grab | awk -v cubeseq=$cubeseq '{split($0,array,","); print array[cubeseq]}'`;
			# printf "cubes $cubeseq: $cube \n";
			cubecol=`echo $cube | awk '{print $2}'`;
			if [ $cubecol == "green" ]; then
				countgreen=$(( `echo $cube | awk '{print $1}'` + $countgreen ));
				cubenumgreen=`echo $cube | awk '{print $1}'`;
				if [ $cubenumgreen -ge $largestgreen ]; then
					largestgreen=$cubenumgreen;
				fi
			elif [ $cubecol == "blue" ]; then
				countblue=$(( `echo $cube | awk '{print $1}'` + $countblue ));
				cubenumblue=`echo $cube | awk '{print $1}'`;
				if [ $cubenumblue -ge $largestblue ]; then
					largestblue=$cubenumblue;
				fi
			elif [ $cubecol == "red" ]; then
				countred=$(( `echo $cube | awk '{print $1}'` + $countred ));
				cubenumred=`echo $cube | awk '{print $1}'`;
				if [ $cubenumred -ge $largestred ]; then
					largestred=$cubenumred;
				fi
			fi
		done
	done
	fuck=`echo $line | awk '{print $2}'`;
	gamenum=`echo $fuck | awk -F"[:]" '{print $1}'`;
	printf "Game Nr $gamenum has $grabnum bag grabs with $countgreen green blocks, $countblue blue blocks and $countred red blocks\n\n";
	if [ $largestblue -gt $limitblue ]; then
		printf "$largestblue blue cubes is more than the limit of $limitblue blue cubes\n";
		printf "Game Nr $gamenum is not possible\n\n";
	elif [ $largestgreen -gt $limitgreen ]; then
		printf "$largestgreen green cubes is more than the limit of $limitgreen green cubes\n";
		printf "Game Nr $gamenum is not possible\n\n";
	elif [ $largestred -gt $limitred ]; then
		printf "$largestred red cubes is more than the limit of $limitred red cubes\n";
		printf "Game Nr $gamenum is not possible\n\n";
	else
		printf "Game Nr $gamenum should be possible\n\n";
		result=$(( `echo $gamenum | awk '{print $1}'` + $result ));
	fi
	echo $result;
done < input.data
