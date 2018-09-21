#!/bin/bash
COUNT=0
TOTAL=$(wc -l ips.txt)

for I in $( < ips.txt); do
  ping -W1 -c1 ${I} > /dev/null 2>&1
  PINGABLE=${?}
  if [[ ${PINGABLE} -eq 0 ]]; then
    let COUNT=${COUNT}+1
    echo "${I} responded to ping."
  else
    echo "${I} failed to respond."
  fi
done
echo "${COUNT} of ${TOTAL} IPs responded to ping."
