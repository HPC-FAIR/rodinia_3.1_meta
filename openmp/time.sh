x=("$@")
#echo ${x[@]}
#pwd

TIMEFORMAT=%R

for (( i=0; i<10; i++ )); 
do
  { time "${x[@]}" > /dev/null; } 2>&1
done | awk ' { total = total + $1; nr++ }
  END {
    if (nr > 0) printf("Average Run Time = %f\n", total/nr);
  }'
