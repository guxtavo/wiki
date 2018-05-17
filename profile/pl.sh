ScS=16
REF=5
SEC=$(date | awk '{print $4}' | cut -d ':' -f 3)
MuP=$(ps -fugfigueira | grep [m]pv | cut -d '"' -f2)

# BUG: if string ends with space, this space is removed, rendering the
#      output to 15 chars instead of 16
# To fix this bug we must evaluate if the echo is spitting 15 or 16 chars
# When it is 15, we must add a # at the end of the string

# + START=4
# + PRINT=' Punk - Instant '
# + '[' 16 -lt 16 ']'
# + echo -n Punk - Instant

# In this case we can see the if doesn't work, as the string has 16 chars.
# The first and last are space. We need to be able to identify such condition
# and rewrite the string

if [ ! -z "$MuP" ]; then
  if [ $SEC -ge 0 -a $SEC -le 4 ]; then
    START=0
    PRINT=${MuP:$START:$ScS}
    if [ "${#PRINT}" -lt 16 ]; then
      echo -n "${PRINT}#"
    else
      echo -n ${PRINT}
    fi
  elif [ $SEC -ge 5 -a $SEC -le 9 ]; then
    START=$(( ( 1 * ( ${#MuP} / ( 59 / $REF ) ) ) -1 ))
    PRINT=${MuP:$START:$ScS}
    if [ "${#PRINT}" -lt 16 ]; then
      echo -n "${PRINT}#"
    else
      echo -n ${PRINT}
    fi
  elif [ $SEC -ge 10 -a $SEC -le 14 ]; then
    START=$(( ( 2 * ( ${#MuP} / ( 59 / $REF ) ) ) -2 ))
    PRINT=${MuP:$START:$ScS}
    if [ "${#PRINT}" -lt 16 ]; then
      echo -n "${PRINT}#"
    else
      echo -n ${PRINT}
    fi
  elif [ $SEC -ge 15 -a $SEC -le 19 ]; then
    START=$(( ( 3 * ( ${#MuP} / ( 59 / $REF ) ) ) -3 ))
    PRINT=${MuP:$START:$ScS}
    if [ "${#PRINT}" -lt 16 ]; then
      echo -n "${PRINT}#"
    else
      echo -n ${PRINT}
    fi
  elif [ $SEC -ge 20 -a $SEC -le 24 ]; then
    START=$(( ( 4 * ( ${#MuP} / ( 59 / $REF ) ) ) -4 ))
    PRINT=${MuP:$START:$ScS}
    if [ "${#PRINT}" -lt 16 ]; then
      echo -n "${PRINT}#"
    else
      echo -n ${PRINT}
    fi
  elif [ $SEC -ge 25 -a $SEC -le 29 ]; then
    START=$(( ( 5 * ( ${#MuP} / ( 59 / $REF ) ) ) -5 ))
    PRINT=${MuP:$START:$ScS}
    if [ "${#PRINT}" -lt 16 ]; then
      echo -n "${PRINT}#"
    else
      echo -n ${PRINT}
    fi
  elif [ $SEC -ge 30 -a $SEC -le 34 ]; then
    START=$(( ( 6 * ( ${#MuP} / ( 59 / $REF ) ) ) -6 ))
    PRINT=${MuP:$START:$ScS}
    if [ "${#PRINT}" -lt 16 ]; then
      echo -n "${PRINT}#"
    else
      echo -n ${PRINT}
    fi
  elif [ $SEC -ge 35 -a $SEC -le 39 ]; then
    START=$(( ( 7 * ( ${#MuP} / ( 59 / $REF ) ) ) -7 ))
    PRINT=${MuP:$START:$ScS}
    if [ "${#PRINT}" -lt 16 ]; then
      echo -n ${PRINT}#
    else
      echo -n ${PRINT}
    fi
  elif [ $SEC -ge 40 -a $SEC -le 44 ]; then
    START=$(( ( 8 * ( ${#MuP} / ( 59 / $REF ) ) ) -8 ))
    PRINT=${MuP:$START:$ScS}
    if [ "${#PRINT}" -lt 16 ]; then
      echo -n "${PRINT}#"
    else
      echo -n ${PRINT}
    fi
  elif [ $SEC -ge 45 -a $SEC -le 49 ]; then
    START=$(( ( 9 * ( ${#MuP}  / ( 59 / $REF ) ) ) -9 ))
    PRINT=${MuP:$START:$ScS}
    if [ "${#PRINT}" -lt 16 ]; then
      echo -n ${PRINT}#
    else
      echo -n ${PRINT}
    fi
  elif [ $SEC -ge 50 -a $SEC -le 54 ]; then
    START=$(( ( 10 * ( ${#MuP} / ( 59 / $REF ) ) ) -10 ))
    PRINT=${MuP:$START:$ScS}
    if [ "${#PRINT}" -lt 16 ]; then
      echo -n ${PRINT}#
    else
      echo -n ${PRINT}
    fi
  elif [ $SEC -ge 55 -a $SEC -le 59 ]; then
    START=$(( ${#MuP} - $ScS ))
    echo -n ${MuP:$START:$ScS}
  fi
fi
