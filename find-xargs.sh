#!/bin/bash

# default to 100 if not set on command line
: ${MAX_FILES:=$1}
: ${MAX_FILES:=100}
echo MAX_FILES: $MAX_FILES

# default to 100 if not set on command line
: ${MAX_ARGS:=$2}
: ${MAX_ARGS:=100}
echo MAX_ARGS: $MAX_ARGS

# if full path to commands is not supplied the PATH is searched until the command is found
# each miss will appear in the errors column in strace -c

FILE_CMD=/usr/bin/file
FIND_CMD=/usr/bin/find
HEAD_CMD=/usr/bin/head
XARGS_CMD=/usr/bin/xargs

# use this command to find the number of executions of FILE_CMD
# strace -f ./find-xargs.sh 2>&1 | grep 'execve("/usr/bin/file"'|wc

#echo Listing files now...
#$FIND_CMD . -type f -name file_\*  | $XARGS --max-chars=1048576 --max-args=$MAX_ARGS $FILE_CMD >/dev/null

($FIND_CMD . -type f -name file_\* | $HEAD_CMD -$MAX_FILES )  | $XARGS_CMD --max-args=$MAX_ARGS $FILE_CMD >/dev/null 


