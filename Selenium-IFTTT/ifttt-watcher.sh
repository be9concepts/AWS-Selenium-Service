#!/bin/bash
# Selenium Bash Script
# Created by @Be9Concepts on Monday, July 10th, 2017
# Last updated on August 4th, 2017 by @Be9Concepts

sudo python2.7 /home/ubuntu/Selenium-IFTTT/__init__.py

RUN='true'
while [[ $RUN = 'true' ]]; do
  RESPONSE=$(curl -s -H "Content-Type: application/json" -X POST -d "{\"operation\":\"GET\",\"ID\":\"101\""}  https://YOURAPI.execute-api.us-east-2.amazonaws.com/Testing/submitdata)
  # echo $RESPONSE
  NEWRESPONSE=$(cut -d "." -f1 <<< $RESPONSE)
  NEWRESPONSE2=$(cut -d "." -f2 <<< $RESPONSE)
  # echo $NEWRESPONSE
  if [[ "$NEWRESPONSE" == '1' ]]; then
      Xvfb :99 -screen 0 1024x768x24 -ac 2<&1 </dev/null &
      export DISPLAY=:99
      echo running the command $NEWRESPONSE2.py
      python2.7 /home/ubuntu/Selenium-IFTTT/tests/$NEWRESPONSE2.py >> /home/output_$NEWRESPONSE2.log
      echo resetting server state in DynamoDB
      curl -H "Content-Type:ion/json" -X POST -d "{\"operation\":\"PUT\",\"id\":\"101\",\"state\":\"-1\",\"command\":\"none\""}  https://l7ufle33og.execute-api.us-east-2.amazonaws.com/Testing/submitdata
      echo done
      # echo waiting again...
      sleep 10
  else
    # response is false
      #echo waiting 5 seconds...
      sleep 5
  fi
done
