# Filename: function_resp_old_new.sh
# Author: Tzu-Yu Jeng
# Date: Feb. 2017
# Description: definition of function `resp_old_new`
# Usage: `resp_old_new foo bar` echoes string `"TRUE"` if `foo` has older
#    last modified date, and `bar` has newer; and `"FALSE"` otherwise.

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

echo "Checking dependency: $@" > /dev/stderr

# To check number of arguments.
# If no. of arguments equals (`-eq`) 0:
if [[ "$#" -eq 0 ]]
then
   echo "   No arguments supplied. 2 expected, 0 present. Stop." > /dev/stderr
   exit 1
# If no. of arguments does not equal to (`-ne`) 2:
elif [[ "$#" -eq 1 ]]
then
   echo "   Too few arguments. 2 expected, 1 present. Stop." > /dev/stderr
   exit 1
# If no. of arguments is strictly greater than (`-gt`) 2:
elif [[ "$#" -gt 2 ]]
then
   echo "   Too many arguments. 2 expected, $# present. Stop." > /dev/stderr
   exit 1
fi

# If both the 1st and 2nd exists:
if [[ ! -f "$1" ]]
then
   echo "   File $1 missing. Stop." > /dev/stderr
   exit 1
fi

if [[ ! -f "$2" ]]
then
   echo "   File $2 missing." > /dev/stderr
   echo "FALSE"
   return 0
fi

# If the 2nd is newer than (`-nt`) the 1st:
if [[ "$2" -nt "$1" ]]
then
   echo "   $2 up-to-date." > /dev/stderr
   echo "TRUE"
else
   echo "   $2 out-of-date. Compiling..." > /dev/stderr
   echo "FALSE"
fi
return 0
