ScS=16
REF=5
SEC=$(date | awk '{print $4}' | cut -d ':' -f 3)
MuP="$(ps -fugfigueira | grep [m]pv | cut -d '"' -f2)"

# BUG: if string ends or begins with space, the spaces are removed, rendering
# the output to 15 (or even 14) chars instead of 16
# To fix this we must evaluate if beginning of end of string has space, and
# replace the space with some other char, like "."

fix_size()
{
  STRING=$1
  PAD=$(( 17 - ${#STRING} ))
  echo -n $PAD
  for i in `seq $PAD`; do
    echo -n "#"
  done
    echo -n ${STRING}
}

if [ ! -z "$MuP" ]; then
  if [ $SEC -ge 0 -a $SEC -le 4 ]; then
    START=0
    PRINT=${MuP:$START:$ScS}
    echo -n ${PRINT}
  elif [ $SEC -ge 5 -a $SEC -le 9 ]; then
    START=$(( ( 1 * ( ${#MuP} / ( 59 / $REF ) ) ) -1 ))
    PRINT=${MuP:$START:$ScS}
    echo -n ${PRINT}
  elif [ $SEC -ge 10 -a $SEC -le 14 ]; then
    START=$(( ( 2 * ( ${#MuP} / ( 59 / $REF ) ) ) -2 ))
    PRINT=${MuP:$START:$ScS}
    echo -n ${PRINT}
  elif [ $SEC -ge 15 -a $SEC -le 19 ]; then
    START=$(( ( 3 * ( ${#MuP} / ( 59 / $REF ) ) ) -3 ))
    PRINT=${MuP:$START:$ScS}
    echo -n ${PRINT}
  elif [ $SEC -ge 20 -a $SEC -le 24 ]; then
    START=$(( ( 4 * ( ${#MuP} / ( 59 / $REF ) ) ) -4 ))
    PRINT=${MuP:$START:$ScS}
    echo -n ${PRINT}
  elif [ $SEC -ge 25 -a $SEC -le 29 ]; then
    START=$(( ( 5 * ( ${#MuP} / ( 59 / $REF ) ) ) -5 ))
    PRINT=${MuP:$START:$ScS}
    echo -n ${PRINT}
  elif [ $SEC -ge 30 -a $SEC -le 34 ]; then
    START=$(( ( 6 * ( ${#MuP} / ( 59 / $REF ) ) ) -6 ))
    PRINT=${MuP:$START:$ScS}
    echo -n ${PRINT}
  elif [ $SEC -ge 35 -a $SEC -le 39 ]; then
    START=$(( ( 7 * ( ${#MuP} / ( 59 / $REF ) ) ) -7 ))
    PRINT=${MuP:$START:$ScS}
    echo -n ${PRINT}
  elif [ $SEC -ge 40 -a $SEC -le 44 ]; then
    START=$(( ( 8 * ( ${#MuP} / ( 59 / $REF ) ) ) -8 ))
    PRINT=${MuP:$START:$ScS}
    echo -n ${PRINT}
  elif [ $SEC -ge 45 -a $SEC -le 49 ]; then
    START=$(( ( 9 * ( ${#MuP}  / ( 59 / $REF ) ) ) -9 ))
    PRINT=${MuP:$START:$ScS}
    echo -n ${PRINT}
  elif [ $SEC -ge 50 -a $SEC -le 54 ]; then
    START=$(( ( 10 * ( ${#MuP} / ( 59 / $REF ) ) ) -10 ))
    PRINT=${MuP:$START:$ScS}
    echo -n ${PRINT}
  elif [ $SEC -ge 55 -a $SEC -le 59 ]; then
    START=$(( ${#MuP} - $ScS ))
    echo -n ${MuP:$START:$ScS}
  fi
fi
