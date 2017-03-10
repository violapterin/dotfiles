#!/usr/bin/env bash

# Filename: combine_audio_and_image_as_video.sh
# Author: Tzu-Yu Jeng
# Date: Feb. 2017
# Description: to save an audio and an image (in still manner) as a video;
#       various formats of both the audio and image are supported.
# Requirement: that open source program `ffmpeg` be installed.
#       (One may use: `brew install ffmpeg`)

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

PROGRAM="ffmpeg"
USAGE="usage: CombineAudioImage <audio> <image> <output_filename>"
# Standstill image and audio file, which will be parsed.
IMAGE=
AUDIO=

# If no. of arguments is strictly less than (`-lt`) 3:
if [[ "$#" -lt 3 ]]
then
   echo "Too few arguments (or none) supplied. 3 expected, $# present. Stop." > /dev/stderr
   echo "${USAGE}"
   exit 1

# If no. of arguments is strictly greater than (`-gt`) 3:
elif [[ "$#" -gt 3 ]]
then
   echo "Too many arguments. 3 expected, $# present. Stop." > /dev/stderr
   echo "${USAGE}"
   exit 1
fi

# To check both the image and audio exist.
if [[ ! -f "$1" ]]
then
   echo "Image $1 does not exist. Stop."
   exit 1
fi

if [[ ! -f "$2" ]]
then
   echo "Audio $2 does not exist. Stop."
   exit 1
fi

image_in="$1"
audio_in="$2"
video_out="$3"

# `ffmpeg` options: (Keep them ordered as such! Do not rearrange!)
options=(
      "-loop 1" # to loop it only once, i.e. no repeatition.
      "-i ${image_in}" # image being input.
      "-i ${audio_in}" # audio being input.
      "-c:v libx264" # to include x264 codec library.
      "-tune stillimage" # to change specific setting: stillimage.
      "-c:a aac" # to use the native advanced audio coding encoder.
      "-b:a 192k" # bit rate, i.e. bits per second.
      "-pix_fmt yuv420p" # pixel format: Y'UV420p, a common color encoding.
      "-shortest" # to finish encoding as the shortest input stream ends.
)

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# To run the main command.
# `set -x` echoes what is executed; `set +x` cancels this.
set -x
"${PROGRAM}" ${options[*]} "${video_out}"
{ set +x; } 2>/dev/null
