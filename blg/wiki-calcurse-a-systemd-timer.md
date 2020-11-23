[Unit]
Description=Update calendar database

[Timer]
OnCalendar=daily
Persistent=true

[Install]
WantedBy=timers.target



[Unit]
Description=Update calendar database
After=network.target

[Service]
Type=oneshot
ExecStart=/home/gfigueira/bin/wiki/parse-todays-calcurse.sh

[Install]
WantedBy=default.target
