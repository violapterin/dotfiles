# Filename: parse_src_bin_name.sh
# Author: Aminopterin (Tzu-Yu Jeng)
# Date: Feb. 2017
# 1st argument: Directory and full name of source (with extension).
# 2nd argument: Directory and full name of binary (with extension).
# 3rd argument: To hold directory of binary.
# 4th argument: To hold bare name of binary.
# Description: To parse source and binary names used in compilation.
# Requirement: No.

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# To check number of arguments.
if [[ "$#" -gt 2 ]]
then
   echo "Incorrect number of argument(s). 4 expected, $# present. Stop." > /dev/stderr
   exit 1


# Otherwise, to set source name to be the 1st argument.
else
   full_src="$1"
fi

# To replace extension of source with that of binary.
if [[ "$#" -eq 1 ]]
then
   bare_bin="${full_src%%.*}"

# To set binary name to be the 2nd argument stripped of extension.
elif [[ "$#" -eq 2 ]]
then
   if [[ "$2" == *"\."* ]]
   then
      echo "Superfluous extension in filename $2 will be stripped." > /dev/stderr
   fi

   bare_bin=$2
   bare_bin="${bare_bin%%.*}"
fi
