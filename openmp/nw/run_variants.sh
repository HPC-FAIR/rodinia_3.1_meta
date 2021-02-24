#!/bin/bash
GPUPERFTOOL=nvprof
CPUPERFTOOL=
APP=(needle needle_offload)

# loop over application variants
for app in "${APP[@]}";
do
LOGDIR="$app-log"
mkdir -p $LOGDIR
file="$LOGDIR/rawdata.csv"

echo "App, thread, inputdata, exetime " > "$file"
# loop over dataset
for (( inputdata=64; inputdata<=4096; inputdata*=2 )); 
do
for (( t=8; t<=128; t*=2 )); 
do
  TESTINPUT=$inputdata  
  export OMP_NUM_THREADS=$t
  echo "Test command: $GPUPERFTOOL  -u ms --log-file $LOGDIR/${t}_${TESTINPUT}.log $app  $inputdata 10 $t"
  $GPUPERFTOOL  -u ms --log-file "$LOGDIR/${t}_${TESTINPUT}.log" $app $inputdata 10 $t&> tmp.log
  exectime=$(grep -oP '(?<=Compute time: )[0-9]+\.[0-9]*' tmp.log)
  echo "$app,$t,$TESTINPUT,$exectime" >> "$file" 
done
done
done


