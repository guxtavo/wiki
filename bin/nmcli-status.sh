#!/bin/bash
echo Connectivity: $(nmcli networking connectivity)
echo
nmcli general status
echo
nmcli device wifi list
echo
nmcli connection show
echo
nmcli monitor
