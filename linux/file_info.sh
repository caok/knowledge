#!/bin/bash
# file_info: simple file information program
#PROGNAME=$(basename $0)
#if [[ -e $1 ]]; then
  #echo -e "\nFile Type:"
  #file $1
  #echo -e "\nFile Status:"
  #stat $1
#else
  #echo "$PROGNAME: usage: $PROGNAME file" >&2
  #return 1
#fi
echo "*********************************************************"

echo $1

file_info () {
  # file_info: function to display file information
  if [[ -e $1 ]]; then
      echo -e "\nFile Type:"
      file $1
      echo -e "\nFile Status:"
      stat $1
  else
      echo "$FUNCNAME: usage: $FUNCNAME file" >&2
      return 1
  fi
}

echo "call file_info function:"
file_info "graylog.md";
