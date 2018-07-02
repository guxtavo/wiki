# FIX ME, add tee to file to sudoers
FILE=/sys/devices/pci0000:00/0000:00:02.0/backlight/acpi_video0/brightness

CURR=$(cat $FILE)

set_value(){
  case $1 in
    up)
      VALUE=$(( $CURR + 1))
      echo $VALUE | sudo tee -a $FILE > /dev/null
      ;;
    down)
      VALUE=$(( $CURR - 1))
      echo $VALUE | sudo tee -a $FILE > /dev/null
      ;;
    *)
      exit 0
      ;;
  esac
}

set_value $1
