#!/bin/bash
# posit-param: script to view command line parameters

#echo "
#Number of arguments: $#
#\$0 = $0
#\$1 = $1
#\$2 = $2
#\$3 = $3
#\$4 = $4
#\$5 = $5
#\$6 = $6
#\$7 = $7
#\$8 = $8
#\$9 = $9
#"


#!/bin/bash
# posit-param2: script to display all arguments
count=1
while [[ $# -gt 0 ]]; do
  echo "Argument $count = $1"
  count=$((count + 1))
  shift
done
