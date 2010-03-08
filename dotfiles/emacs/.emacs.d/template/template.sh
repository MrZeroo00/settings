#!/bin/sh

while getopts "abc:d:" flag; do
  case ${flag} in
    \?) OPT_ERROR=1; break;;
    a) opt_a=true;;
    b) opt_b=true;;
    c) opt_c="${OPTARG}";;
    d) opt_d="${OPTARG}";;
  esac
done

shift $(( $OPTIND - 1 ))

if [ $OPT_ERROR ]; then
  echo >&2 "usage: ..."
  exit 1
fi
