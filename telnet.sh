port='22'
file='ip.txt'
while read line
do
  ip=$( echo "$line" |cut -d ' ' -f 1 )
  #ip=`cat ip.txt | awk '{print $1}'`
  #port=$( echo "$line" |cut -d ' ' -f 2 ) # for multiple port mention ip and port line wise in ip.txt file
  if  telnet  $ip $port </dev/null 2>&1 | grep -q Escape
  then
    echo "$ip $port Connected" >> Telnet_Success.txt
  elif  telnet  $ip $port </dev/null 2>&1 | grep -q "Connection refused"
  then
    echo "$ip $port Connection refused " >> Telnet_Refused.txt
  else
    echo "$ip $port Failed" >> Telnet_Failure.txt
  fi
done < $file


###########note
#make a file with ip.txt name and put all server ip list in this file
# for multiple port mention ip and port line wise in ip.txt file
#Example  1.1.1.1 22
#         2.2.2.2 80
#         3.3.3.3 22
#and uncomment 7th line of script and comment the 1st line of script.
################@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@


#port='22'
#TIMEOUT='3'
file='ip.txt'
while read line
do
  ip=$( echo "$line" | awk '{print $1}')
  #ip=$( echo "$line" |cut -d ' ' -f 1 )
  #ip=`cat ip.txt | awk '{print $1}'`
  port=$( echo "$line" | awk '{print $2}' )
  #port=$( echo "$line" |cut -d ' ' -f 2 ) # for multiple port mention ip and port line wise in ip.txt file
  #if timeout $TIMEOUT telnet $ip $port </dev/null 2>&1 | grep -q Escape
  #if echo 'quit' | timeout --signal=9 2 telnet $ip $port </dev/null 2>&1 | grep -q Escape
  if timeout --foreground --signal=9 2 telnet $ip $port </dev/null 2>&1 | grep -q -m1 Escape
  then
    echo "$ip $port Connected" >> Telnet_Success.txt
  elif  timeout --foreground --signal=9 2 telnet  $ip $port </dev/null 2>&1 | grep -q -m1 refused
  then
    echo "$ip $port Connection refused " >> Telnet_Refused.txt
  else
    echo "$ip $port Failed" >> Telnet_Failure.txt
  fi
done < $file


###########note
#make a file with ip.txt name and put all server ip list in this file
# for multiple port mention ip and port line wise in ip.txt file
#Example  1.1.1.1 22
#         2.2.2.2 80
#         3.3.3.3 22
#and uncomment 7th line of script and comment the 1st line of script.
