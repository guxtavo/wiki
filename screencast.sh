ffmpeg -s 1920x1080 -r 5 -f x11grab -i :1.0 \
-f alsa -ac 2 -i hw:0 \
-acodec libvorbis -qscale:a 5 \
-vcodec theora -qscale:v 8 -s 1280x720 \
screencast.ogv
