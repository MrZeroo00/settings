#!/bin/sh

PLUGIN_PATH=$HOME/.vimperator/plugin

mkdir $PLUGIN_PATH\_tmp
cd $PLUGIN_PATH\_tmp
for i in `ls $PLUGIN_PATH`; do
  wget http://svn.coderepos.org/share/lang/javascript/vimperator-plugins/trunk/`basename $i`
done

rm -rf $PLUGIN_PATH\_old
mv $PLUGIN_PATH $PLUGIN_PATH\_old
mv $PLUGIN_PATH\_tmp $PLUGIN_PATH
