#!/bin/bash

# seeds
seedlist=$(grep "seeds" test.data | awk -F"[:]" '{print $2}');
echo $seedlist | awk '{for (i=1;i<=NF;i++) print $i}';

# seed-to-soil
sed -n '/seed-to-soil/,/^$/p' test.data | tail -n +2 | sed -r '/^\s*$/d' | while read -r seed2soil; do
	seed2soilsource=$(echo $seed2soil | awk '{print $2}');
	seed2soildest=$(echo $seed2soil | awk '{print $1}');
	seed2soilrangecount=0;
	for seed2soilrange in $(seq 0 $(( $(echo $seed2soil | awk '{print $3}') - 1 ))); do
		seed2soilsource=$(( $seed2soilsource + $seed2soilrangecount ))
		seed2soildest=$(( $seed2soildest + $seed2soilrangecount ))
		echo "source $seed2soilsource -> dest $seed2soildest";
		seed2soilrangecount=1;
	done
done
