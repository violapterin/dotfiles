# `EXT_BIN` need to be defined in advance.
# To check number of arguments.
if [ "$#" -eq 0 ]; then
   echo "No arguments supplied. 1 or 2 expected, 0 present. Stop."
   exit 1

elif [ "$#" -gt 2 ]; then
   echo "Too many arguments. 1 or 2 expected, $# present. Stop."
   exit 1
else
   # To set source name to be the 1st argument.
   name_src="$1"
fi

# To replace extension of source with that of binary.
if [ "$#" -eq 1 ]; then
   basename_bin="${name_src%%.*}"

# To set binary name to be the 2nd argument stripped of extension.
elif [ "$#" -eq 2 ]; then
   if [[ "$2" == *"\."* ]]; then
      echo "Superfluous extension in filename $2 will be stripped."
   fi

   basename_bin=$2
   basename_bin="${basename_bin%%.*}"
fi
