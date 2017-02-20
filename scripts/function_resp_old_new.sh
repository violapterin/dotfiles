# Filename: function_resp_old_new.sh
# Author: Tzu-Yu Jeng
# Date: Feb. 2017
# Description: definition of function `resp_old_new`
# Usage: foo bar` echoes string `TRUE` if `foo` has older, and `bar`
#    has newer last modified date; and echoes `FALSE` otherwise.

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

function redirect ()
{
   echo "$1" > /dev/stderr
}

function resp_old_new ()
{
   redirect "Checking dependency: $@"

   # To check number of arguments.
   # If no. of arguments equals (`-eq`) 0:
   if [ "$#" -eq 0 ]; then
      redirect  "   No arguments supplied. 2 expected, 0 present. Stop."
      exit 1
   # If no. of arguments does not equal to (`-ne`) 2:
   elif [ "$#" -eq 1 ]; then
      redirect "   Too few arguments. 2 expected, 1 present. Stop."
      exit 1
   # If no. of arguments is strictly greater than (`-gt`) 2:
   elif [ "$#" -gt 2 ]; then
      redirect "   Too many arguments. 2 expected, $# present. Stop."
      exit 1
   fi

   # If both the 1st and 2nd exists:
   if [ ! -f "$1" ]; then
      redirect "   File $1 missing. Stop."
      exit 1
   fi
   if [ ! -f "$2" ]; then
      redirect "   File $2 missing."
      echo "FALSE"
      return 0
   fi

   # If the 2nd is newer than (`-nt`) the 1st:
   if [ "$2" -nt "$1" ]; then
      redirect "   $2 up-to-date."
      echo "TRUE"
   else
      redirect "   $2 out-of-date. Compiling..."
      echo "FALSE"
   fi
   return 0
}
