#!/bin/bash

# Colors
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# select branch
if [ $# -eq 0 ]
    then # no branch provided
        TARGET_BRANCH='develop'
    else # use first argument as branch
        TARGET_BRANCH="$1"
fi

# get current branch
CUR_BRANCH=$(git symbolic-ref HEAD | sed -e 's,.*/\(.*\),\1,')
TAR_BRANCH_SHORT=$(echo $TARGET_BRANCH | sed -e 's,.*/\(.*\),\1,')

echo -e "Open PR to merge ${CYAN}$CUR_BRANCH${NC} into ${CYAN}$TAR_BRANCH_SHORT${NC}"

echo -e "Merge $CUR_BRANCH into $TAR_BRANCH_SHORT" > testfile

hub pull-request -F testFile -b cheeseonhead:$TARGET_BRANCH
rm testFile
