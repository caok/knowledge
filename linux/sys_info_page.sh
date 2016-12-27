#!/bin/bash
# Program to output a system information page

#TITLE="System Information Report For $HOSTNAME"
#CURRENT_TIME=$(date +"%x %r %Z")
#TIME_STAMP="Generated $CURRENT_TIME, by $USER"
#echo "<HTML>
#        <HEAD>
#                <TITLE>$TITLE</TITLE>
#        </HEAD>
#        <BODY>
#                <H1>$TITLE</H1>
#                <P>$TIME_STAMP</P>
#        </BODY>
#</HTML>"


#TITLE="System Information Report For $HOSTNAME"
#CURRENT_TIME=$(date +"%x %r %Z")
#TIME_STAMP="Generated $CURRENT_TIME, by $USER"
#cat << _EOF_
#<HTML>
#         <HEAD>
#                <TITLE>$TITLE</TITLE>
#         </HEAD>
#         <BODY>
#                <H1>$TITLE</H1>
#                <P>$TIME_STAMP</P>
#         </BODY>
#</HTML>
#_EOF_

#!/bin/bash
# Program to output a system information page
TITLE="System Information Report For $HOSTNAME"
CURRENT_TIME=$(date +"%x %r %Z")
TIME_STAMP="Generated $CURRENT_TIME, by $USER"

report_uptime () {
  cat <<- _EOF_
    <H2>System Uptime</H2>
    <PRE>$(uptime)</PRE>
_EOF_
  return
}
report_disk_space () {
  cat <<- _EOF_
  <H2>Disk Space Utilization</H2>
  <PRE>$(df -h)</PRE>
_EOF_
  return
}
report_home_space () {
  cat <<- _EOF_
  <H2>Home Space Utilization</H2>
  <PRE>$(du -sh /home/*)</PRE>
_EOF_
  return
}

cat << _EOF_
<HTML>
    <HEAD>
        <TITLE>$TITLE</TITLE>
    </HEAD>
    <BODY>
        <H1>$TITLE</H1>
        <P>$TIME_STAMP</P>
        $(report_uptime)
        $(report_disk_space)
        $(report_home_space)
    </BODY>
</HTML>
_EOF_
