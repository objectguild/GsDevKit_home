#! /usr/bin/env bash
#=========================================================================
# Copyright (c) 2019 GemTalk Systems, LLC <dhenrich@gemtalksystems.com>.
#
#   MIT license: https://github.com/GsDevKit/GsDevKit_home/blob/master/license.txt
#=========================================================================

theArgs="$*"
source "${GS_HOME}/bin/private/shFeedback"
start_banner

#
# This script does the dirty work needed to get to the point where 
# 	gsdevkit_launcher scripts can be run

set -x # so we can see what is going on 

gsdevkit_launcher_version="v0.10.0"

cd $GS_HOME/shared/gemstone

if [ ! -d product ] ; then 
	# make sure 3.5.0 is installed and create symbolic link to the 3.5.0 product tree
	$GS_HOME/bin/downloadGemStone 3.5.0
	if [ ! -d "$GS_HOME/shared/downloads/products/GemStone64Bit3.5.0-x86_64.Linux" ] ; then
		# not Linux
		if [ ! -d "$GS_HOME/shared/downloads/products/GemStone64Bit3.5.0-i386.Darwin" ] ; then
			# not Mac
			exit_1_banner "gsdevkit_launcher currently supported only on Mac or Linux platforms"
		else
			ln -s $GS_HOME/shared/downloads/products/GemStone64Bit3.5.0-i386.Darwin product
		fi
	else
		ln -s $GS_HOME/shared/downloads/products/GemStone64Bit3.5.0-x86_64.Linux product
	fi
fi

# download and install the gsdevkit_launcher solo extent 
pushd snapshots
	curl  -L -O -s -S "https://github.com/GsDevKit/GsDevKit_home/releases/download/v0.10.0/extent0.gsdevkit_launcher.dbf.zip"
	rm -rf extent0.gsdevkit_launcher.dbf
	unzip -q  extent0.gsdevkit_launcher.dbf.zip
popd

# End of script
exit_0_banner "...finished"
