FILE=$1
LAST=1

for a in $(grep -n "^#" $FILE | awk '{print $1}' | tr -d ":#")
do
  clear
  sed -ne $LAST,$(( $a -1 ))p $FILE
  read
  LAST=$(echo $a)
done
