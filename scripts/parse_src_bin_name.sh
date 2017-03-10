# Filename: parse_src_bin_name.sh
# Author: Aminopterin (Tzu-Yu Jeng)
# Date: Feb. 2017
# Description: If included in a script, this parses input arguments;
#    when there are two arguments, the 1st is source, the 2nd binary
#    without extension; when there is only one, it is source, and the
#    binary's name is obtained by substituting source's extension.
# Requirement: That `EXT_BIN` be defined in the including script.

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# The fullname of source will be saved as `full_src`.
# The basename of binary will be saved as `bare_bin`.
full_src=
bare_bin=

# To check number of arguments.
# If no. of arguments equals (`-eq`) 0:
if [[ "$#" -eq 0 ]]
then
   echo "No arguments supplied. 1 or 2 expected, 0 present. Stop." > /dev/stderr
   exit 1

# If no. of arguments is strictly greater than (`-gt`) 2:
elif [[ "$#" -gt 2 ]]
then
   echo "Too many arguments. 1 or 2 expected, $# present. Stop." > /dev/stderr
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
