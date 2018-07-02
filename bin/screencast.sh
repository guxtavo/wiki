#!/bin/bash
#
# screencast -m 100
# record 100 mb
#
# screencast -s
# record with sound

#AUDIO_DEVICE=$(arecord -l | grep Plantro | awk '{print $2}' | tr -d ":")

check_options()
{
echo oi
}

record_with_sound()
{
	stat screencast.ogv > /dev/null 2>&1 && rm -rf screencast.ogv

	tmux set -g status off

	ffmpeg -s 1920x1080 -r 1 -f x11grab -i :1.0 \
		-f alsa -ac 2 -ar 44100 -i hw:1 \
		-acodec libvorbis -qscale:a 5 \
		-vcodec theora -qscale:v 8 -s 1920x1080 \
		screencast.ogv >ffmpeg.log 2>&1 &
	FFMPEG_PID=$!
	echo "kill -15 $FFMPEG_PID to stop recording"
}

#stop_recording()
#{##
#	echo -n "type end to finish the recording: "
#	read A
#	if test $A -eq "end"
#	  then
#	    kill -15 $FFMPEG_PID
#	    tmux set -g status off
#	fi
#}

main()
{
	record_with_sound
}

main
