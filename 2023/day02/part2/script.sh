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
	result=$(( ($largestgreen * $largestblue * $largestred) + $result ))
	printf "The result is $result \n\n";
done < input.data
