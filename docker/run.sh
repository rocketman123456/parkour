#!/bin/bash
set -e
set -u

SCRIPTROOT="$( cd "$(dirname "$0")" ; pwd -P )"

if [ $# -eq 0 ]
then
    echo "running docker without display"
    docker run -it --rm -v ${SCRIPTROOT}/..:/home/root/rl_ws --network=host --gpus=1 --name=parkour_container parkour /home/root/rl_ws/setup.sh
else
    export DISPLAY=$DISPLAY
	echo "setting display to $DISPLAY"
	xhost +
	docker run -it --rm -v /tmp/.X11-unix:/tmp/.X11-unix -v /home/fzq/.Xauthority:/root/.Xauthority -e DISPLAY=$DISPLAY -v ${SCRIPTROOT}/..:/home/root/rl_ws --network=host --gpus=1 --name=parkour_container parkour /home/root/rl_ws/setup.sh
	# xhost -
fi
