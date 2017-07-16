  GNU nano 2.5.3            File: ifttt-watcher.sh                              

#!/bin/bash
# Selenium Bash Script
# Created by @Be9Concepts on Monday, July 10th, 2017

# Start Services Required

Xvfb :99 -screen 0 1024x768x24 -ac 2<&1 </dev/null &
export DISPLAY=:99

# Load __init__.py with python2.7
python2.7 __init__.py

URL="http://be9concepts.com/Selenium-IFTTT/notify.php"
RUN='true'
echo waiting...
while [[ $RUN = 'true' ]]; do
  RESPONSE=$(curl -s  $URL)
  #echo $RESPONSE
  NEWRESPONSE=$(cut -d "." -f1 <<< $RESPONSE)
  NEWRESPONSE2=$(cut -d "." -f2 <<< $RESPONSE)

  if [[ "$NEWRESPONSE" == 'true' ]]; then
       echo running command $NEWRESPONSE2
       sudo python2.7 tests/$NEWRESPONSE2.py
       echo resetting server state
       curl -s 'https://be9concepts.com/Selenium-IFTTT/update.php?state=false&c$
       echo done
       echo waiting again...
       sleep 10
  else
    # response is false
      #echo waiting 5 seconds...
      sleep 5
  fi
done
