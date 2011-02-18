#!/bin/sh

# read common environment
if [ -f ${HOME}/.shenv ]; then
  source ${HOME}/.shenv
fi

## include .shrc if it exists
#if [ -f ${HOME}/.shrc ]; then
#  source ${HOME}/.shrc
#fi

# local setting
if [ -f ${HOME}/.profile.local ]; then
  source ${HOME}/.profile.local
fi
