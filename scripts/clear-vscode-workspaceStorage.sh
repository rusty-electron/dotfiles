#!/bin/sh

# bash delete folders older than a certain amount of days
#
LOCATION="/home/$USER/.config/Code/User/workspaceStorage"
DAYS=20
size_before=$(du -sh $LOCATION | cut -f1)
# if ran successfully, echo "Success"
find $LOCATION -type d -mtime +$DAYS -exec rm -rf {} \; > /dev/null 2>&1
size_after=$(du -sh $LOCATION | cut -f1)

echo "Size before: $size_before"
echo "Size after: $size_after"
