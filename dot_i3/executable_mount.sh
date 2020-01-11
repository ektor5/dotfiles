#!/bin/bash

declare -a MOUNTS
declare -a COMMANDS
num=0
COMMAND="udisksctl mount -b"

read -r -d '' HEAD <<'EOF'
mode "$mount" {

EOF

for disk in /dev/sdd{1..2} /dev/sde{1..2} /dev/mmcblk0p{1..2}
do
  if [[ -z "$(lsblk $disk -no MOUNTPOINT)" ]]
  then
    let num++
    COMMANDS+=("bindsym $num exec $COMMAND $disk
    ")
    MOUNTS+=("$num: $disk")
  fi
done 

read -r -d '' BODY <<EOF

${COMMANDS[*]}
EOF

read -r -d '' TAIL <<EOF

  bindsym Return mode "default"
  bindsym Escape mode "default"
}
EOF

if (( num = 0 )) 
then
  i3-msg mode "default"
  echo "no mounts found"
  exit 0
fi
    
echo set '$mount' "mount: ${MOUNTS[*]}"
echo "$HEAD $BODY $TAIL"
