#!/bin/bash

if brew ls --versions sourcery > /dev/null;
then
  if [[ -f ".sourcery.yml" ]]
  then
    sourcery
  fi
fi
