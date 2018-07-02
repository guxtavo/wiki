SS=$(stty size | awk '{print $2}')
while true; do
  for j in 4 8 16 24 32 24 16 8; do
    for k in `seq $j`; do
      echo -n " "
    done
    for i in `seq $(( $SS -( $j * 2) ))`; do
      echo -n X
    done
    for k in `seq $j`; do
      echo -n " "
    done
    sleep .05
  done
done
