#!/bin/bash

URL="https://example.com/api"
BODY_PREFIX="{\"key\":"
BODY_SUFFIX="}"

for i in {1..50}; do
    BODY="$BODY_PREFIX$i$BODY_SUFFIX"
	echo "Sending request $i with body $BODY"
    curl -X POST -H "Content-Type: application/json" -d "$BODY" "$URL" &
done

wait
