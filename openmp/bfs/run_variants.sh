#!/bin/bash
CPUPERFTOOL=vtune 
APP=(bfs )

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
  echo "Vtune command: $CPUPERFTOOL  -collect threading -r $LOGDIR/bfs_tr_${t}_${TESTINPUT} --  $app $t $inputdata "
  $CPUPERFTOOL  -collect threading -r $LOGDIR/bfs_tr_${t}_${TESTINPUT} --  $app $t $inputdata 
  echo "Vtune command: $CPUPERFTOOL -report summary -format=csv -report-knob show-issues=false  -r $LOGDIR/bfs_tr_${t}_${TESTINPUT} > $LOGDIR/${t}_${TESTINPUT}_tr.log "
  $CPUPERFTOOL -report summary -format=csv -report-knob show-issues=false  -r $LOGDIR/bfs_tr_${t}_${TESTINPUT} > $LOGDIR/${t}_${TESTINPUT}_tr.log 
#

  echo "Vtune command: $CPUPERFTOOL  -collect hpc-performance -r $LOGDIR/bfs_hpc_${t}_${TESTINPUT} --  $app $t $inputdata "
  $CPUPERFTOOL  -collect hpc-performance -r $LOGDIR/bfs_hpc_${t}_${TESTINPUT} --  $app $t $inputdata 
  echo "Vtune command: $CPUPERFTOOL -report summary -format=csv -report-knob show-issues=false  -r $LOGDIR/bfs_hpc_${t}_${TESTINPUT} > $LOGDIR/${t}_${TESTINPUT}_hpc.log "
  $CPUPERFTOOL -report summary -format=csv -report-knob show-issues=false  -r $LOGDIR/bfs_hpc_${t}_${TESTINPUT} > $LOGDIR/${t}_${TESTINPUT}_hpc.log 
#  exectime=$(grep -oP '(?<=Compute time: )[0-9]+\.[0-9]*' tmp.log)
#  echo "$app,$t,$TESTINPUT,$exectime" >> "$file" 
done
done
done


