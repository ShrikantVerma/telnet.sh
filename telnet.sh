port=22
file=ip.txt
while read line
do
  ip=$( echo "$line" |cut -d ' ' -f 1 )
  port=$( echo "$line" |cut -d ' ' -f 2 )
  if  telnet  $ip $port </dev/null 2>&1 | grep -q Escape
  then
    echo "$ip $port Connected" >> Telnet_Success.txt
  elif  telnet  $ip $port </dev/null 2>&1 | grep -q refused
  then
    echo "$ip $port Refused" >> Telnet_Refused.txt
  else
    echo "$ip $port Failed" >> Telnet_Failure.txt
  fi
done < $file


###########note
#make a file with ip.txt name and put all server ip list in this file
