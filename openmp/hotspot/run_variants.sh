#!/bin/bash
GPUPERFTOOL=nvprof
CPUPERFTOOL=
APP=(hotspot hotspot_offload)

DATADIR="../../data/hotspot" 

# loop over application variants
for app in "${APP[@]}";
do
LOGDIR="$app-log"
mkdir -p $LOGDIR
file="$LOGDIR/rawdata.csv"

echo "App, thread, inputdata, exetime " > "$file"
# loop over dataset
for inputdata in 64 512 1024;
do
for (( t=8; t<=128; t*=2 )); 
do
  tempinut=$DATADIR/temp_${inputdata}
  powerinput=$DATADIR/power_${inputdata}
  echo "Test command: $GPUPERFTOOL  -u ms --log-file $LOGDIR/${t}_${inputdata}.log $app $inputdata $inputdata 2 $t $tempinut $powerinput output.out"
  $GPUPERFTOOL  -u ms --log-file "$LOGDIR/${t}_${inputdata}.log" $app $inputdata $inputdata 2 $t $tempinut $powerinput output.out &> tmp.log
  exectime=$(grep -oP '(?<=Compute time: )[0-9]+\.[0-9]*' tmp.log)
  echo "$app,$t,$inputdata,$exectime" >> "$file" 
done
done
done


