#!/bin/bash

# seeds
seedlist=$(grep "seeds" test.data | awk -F"[:]" '{print $2}');
# echo $seedlist | awk '{for (i=1;i<=NF;i++) print $i}';

# function fuck() {
# for i in $2; do
# 	if [ $i -eq $seed2soilsource ]; then
# 		echo "seed $i belongs to dest $seed2soildest";
# 		found="$found $i";
# 	fi
# done
# }

function nervigeszeug() {
sed -n "/$1/,/^\$/p" test.data | tail -n +2 | sed -r '/^\s*$/d' | { while read -r seed2soil; do
	seed2soilsource=$(echo $seed2soil | awk '{print $2}');
	seed2soildest=$(echo $seed2soil | awk '{print $1}');
	seed2soilrangecount=0;
	for seed2soilrange in $(seq 0 $(( $(echo $seed2soil | awk '{print $3}') - 1 ))); do
		seed2soilsource=$(( $seed2soilsource + $seed2soilrangecount ))
		seed2soildest=$(( $seed2soildest + $seed2soilrangecount ))
		# echo "source $seed2soilsource -> dest $seed2soildest";
		seed2soilrangecount=1;
		for i in $2; do
			if [ $i -eq $seed2soilsource ]; then
				echo "seed $i belongs to dest $seed2soildest";
				found="$found $i";
				dest="$dest $seed2soildest"
		fi
		done
	done
	# echo $found;
done
for i in $seedlist; do
	y=0;
	z=0;
	for j in $found; do
		if [ $i -eq $j ]; then
			y=1;
			z=1;
		fi
	done
	for d in $dest; do
		if [ $i -eq $d ]; then
			z=1;
		fi
	done
if [ $y -eq "0" ]; then
	# echo $seed2soil;
	echo "seed $i belongs to dest $i";
elif [ $z -eq "0" ]; then
	echo "source $i belongs to dest $d";
fi
done
} }

for line in "seed-to-soil" "soil-to-fertilizer"; do 
	nervigeszeug "$line" "$seedlist"
done

# "fertilizer-to-water" "water-to-light" "light-to-temperature" "temperature-to-humidity" "humidity-to-location"
