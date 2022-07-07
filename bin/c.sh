#!/bin/sh

PACKAGE=`pwd | grep -E -o "[^/]+$"`
URL=https://code.amazon.com/packages/$PACKAGE
echo $URL
open $URL
