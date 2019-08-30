#!/bin/bash

sudo journalctl -xe | grep openvpn > openvpn.lines

# things to remove
# "Initialization Sequence Completed"
# "Restart pause,"
