#!/usr/bin/env bash

# Filename: combine_audio_and_image_as_video.sh
# Author: Tzu-Yu Jeng
# Date: Feb. 2017
# Description: to save an audio and an image (in still manner) to a video;
#       various formats of both the audio and image are supported.
# Requirement: having installed open source binary `ffmpeg`

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

CONVERTER="pandoc"

"${CONVERTER}" -loop 1 -i image.jpg -i audio.wav -c:v libx264 -tune stillimage -c:a aac -strict experimental -b:a 192k -pix_fmt yuv420p -shortest out.mp4


ffmpeg -loop 1 -i image.jpg -i audio.wav -c:v libx264 -tune stillimage -c:a aac -strict experimental -b:a 192k -pix_fmt yuv420p -shortest out.mp4

# `ffmpeg` options:
# XXX !!!! TODO: understand meaning of options
options=(
      "--standalone"
      "--output=${bare_name_bin}${EXT_BIN}"
      "--template=${TEMPLATE_PANDOC}"
      "--latex-engine=${ENGINE}"
)


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# To run the main command.
# `set -x` echoes what is executed; `set +x` cancels this.
set -x
"${CONVERTER}" ${options[*]} "${full_name_src}"
{ set +x; } 2>/dev/null