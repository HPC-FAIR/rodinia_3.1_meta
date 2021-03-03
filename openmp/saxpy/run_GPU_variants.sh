#!/bin/bash
GPUPERFTOOL=nvprof
GPUPERFFLAG="--events all --metrics all"
APP=(saxpy_offload)


# loop over application variants
for app in "${APP[@]}";
do
LOGDIR="$app-log"
mkdir -p $LOGDIR
file="$LOGDIR/rawdata.csv"

echo "App, thread, inputdata, exetime " > "$file"
# loop over dataset
for (( t=4; t<=256; t*=2 )); 
do
  TESTINPUT="default"  
  echo "Test command: $GPUPERFTOOL $GPUPERFFLAG  -u ms --log-file $LOGDIR/${t}_${TESTINPUT}.log $app $t "
  $GPUPERFTOOL $GPUPERFFLAG -u ms --log-file "$LOGDIR/${t}_${TESTINPUT}.log" $app $t &> tmp.log
  exectime=$(grep -oP '(?<=Compute time: )[0-9]+\.[0-9]*' tmp.log)
  echo "$app,$t,$TESTINPUT,$exectime" >> "$file" 
done
done


