#!/bin/sh

PLUGIN_PATH=$HOME/.vimperator/plugin
PLUGIN_LIST=$HOME/.vimperator/GetLatest/GetLatestVimperatorPlugins.dat

mkdir $PLUGIN_PATH\_tmp
cd $PLUGIN_PATH\_tmp
for i in `cat $PLUGIN_LIST`; do
  wget http://svn.coderepos.org/share/lang/javascript/vimperator-plugins/trunk/`basename $i`
done

rm -rf $PLUGIN_PATH\_old
mv $PLUGIN_PATH $PLUGIN_PATH\_old
mv $PLUGIN_PATH\_tmp $PLUGIN_PATH
mv $PLUGIN_PATH\_old/.svn $PLUGIN_PATH
