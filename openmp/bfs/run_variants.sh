#!/bin/bash
GPUPERFTOOL=nvprof
CPUPERFTOOL=
APP=(bfs_offload)

DATADIR="../../data/bfs" 

# loop over application variants
for app in "${APP[@]}";
do
LOGDIR="$app-log"
mkdir -p $LOGDIR
file="$LOGDIR/rawdata.csv"

echo "App, thread, inputdata, exetime " > "$file"
# loop over dataset
for inputdata in "$DATADIR"/*.txt;
do
for (( t=8; t<=128; t*=2 )); 
do
  TESTINPUT=$(basename $inputdata)  
  TESTINPUT="${TESTINPUT%.*}" 
  echo "Test command: $GPUPERFTOOL  -u ms --log-file $LOGDIR/${t}_${TESTINPUT}.log $app $t $inputdata"
  $GPUPERFTOOL  -u ms --log-file "$LOGDIR/${t}_${TESTINPUT}.log" $app $t $inputdata &> tmp.log
  exectime=$(grep -oP '(?<=Compute time: )[0-9]+\.[0-9]*' tmp.log)
  echo "$app,$t,$TESTINPUT,$exectime" >> "$file" 
done
done
done


