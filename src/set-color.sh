#!/bin/bash
STATUS=$1

if [ "$STATUS" == "success" ]; then
  echo "color=#36a64f" >> "$GITHUB_OUTPUT"
else
  echo "color=#FF0000" >> "$GITHUB_OUTPUT"
fi
