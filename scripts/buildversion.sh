#!/bin/sh
# Script to generate a C file with version information.
OUTFILE="$1"
VAR16MODE="$2"

# Extract version info
if [ -d .git -o -f .git ]; then
    VERSION="`git describe --tags`"
elif [ -f .version ]; then
    VERSION="`cat .version`"
else
    VERSION="?"
fi
VERSION="${VERSION}-`date +"%Y%m%d"`-MattDevo"
echo "Version: ${VERSION}"

# Build header file
if [ "$VAR16MODE" = "VAR16" ]; then
    cat > ${OUTFILE} <<EOF
#include "types.h"
char VERSION[] VAR16 = "${VERSION}";
EOF
else
    cat > ${OUTFILE} <<EOF
char VERSION[] = "${VERSION}";
EOF
fi
