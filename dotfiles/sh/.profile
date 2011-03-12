#!/bin/sh

## include .shrc if it exists
#if [ -f ${HOME}/.shrc ]; then
#  source ${HOME}/.shrc
#fi


# Ruby Version Manager (RVM)
if [ -s ${HOME}/.rvm/scripts/rvm ]; then
  source ${HOME}/.rvm/scripts/rvm
fi


# local setting
if [ -f ${HOME}/.profile.`hostname -s`.local ]; then
  source ${HOME}/.profile.`hostname -s`.local
fi
