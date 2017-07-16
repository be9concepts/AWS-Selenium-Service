#!/bin/bash
# Selenium Bash Script
# Created by @Be9Concepts on Monday, July 10th, 2017

# Start Services Required

Xvfb :99 -screen 0 1024x768x24 -ac 2<&1 </dev/null &
export DISPLAY=:99

# Load __init__.py with python2.7
python2.7 __init__.py

RUN='true'
echo waiting...
while [[ $RUN = 'true' ]]; do
  RESPONSE=$(curl -H "Content-Type: application/json" -X POST -d "{\"operation\":\"GET\",\"ID\":\"101\""}  https://l7ufle33og.execute-api.us-east-2.amazonaws.com/Testing/submitdata)
  echo $RESPONSE
  NEWRESPONSE=$(cut -d "." -f1 <<< $RESPONSE)
  NEWRESPONSE2=$(cut -d "." -f2 <<< $RESPONSE)
  echo $NEWRESPONSE
  if [[ "$NEWRESPONSE" == '1' ]]; then
       echo running command $NEWRESPONSE2
       sudo python2.7 tests/$NEWRESPONSE2.py
       echo resetting server state
       curl -H "Content-Type:ion/json" -X POST -d "{\"operation\":\"PUT\",\"id\":\"101\",\"state\":\"-1\",\"command\":\"none\""}  https://l7ufle33og.execute-api.us-east-2.amazonaws.com/Testing/submitdata
       echo done
       echo waiting again...
       sleep 10
  else
    # response is false
      #echo waiting 5 seconds...
      sleep 5
  fi
done
