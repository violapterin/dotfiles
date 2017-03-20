#!/usr/bin/env bash

# Filename: combine_audio_and_image_as_video.sh
# Author: Aminopterin (Tzu-Yu Jeng)
# Date: Feb. 2017
# Description: To save an audio and an image (in still manner) as a video;
#    various formats of both the audio and image are supported.
# Requirement: That `ffmpeg` be installed (use: `brew install ffmpeg`).
# Usage: `combine_audio_and_image_as_video.sh <input_audio> <input_image> <output_filename>`

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

PROGRAM="ffmpeg"

# If no. of arguments is strictly less than (`-lt`) 3:
if [[ "$#" -lt 3 ]]
then
   echo "Too few arguments (or none) supplied. 3 expected, $# present. Stop." > /dev/stderr
   exit 1

# If no. of arguments is strictly greater than (`-gt`) 3:
elif [[ "$#" -gt 3 ]]
then
   echo "Too many arguments. 3 expected, $# present. Stop." > /dev/stderr
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
      # To loop it only once, i.e. no repeatition.
      "-loop 1"
      # Image being input.
      "-i ${image_in}"
      # Audio being input.
      "-i ${audio_in}"
      # To include x264 codec library.
      "-c:v libx264"
      # To change specific setting: stillimage.
      "-tune stillimage"
      # To use the native advanced audio coding encoder.
      "-c:a aac"
      # Bit rate, i.e. bits per second.
      "-b:a 192k"
      # Pixel format: Y'UV420p, a common color encoding.
      "-pix_fmt yuv420p"
      # To truncate width and height to be both even number, as required.
      "-vf scale=trunc(iw/2)*2:trunc(ih/2)*2"
      # To finish encoding as the shortest input stream ends.
      "-shortest"
)

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# To run the main command.
# `set -x` echoes what is executed; `set +x` cancels this.
set -x
"${PROGRAM}" ${options[*]} "${video_out}"
{ set +x; } 2>/dev/null
