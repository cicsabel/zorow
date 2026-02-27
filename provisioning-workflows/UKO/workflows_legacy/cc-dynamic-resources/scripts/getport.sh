#!/bin/sh
# Usage: ./getport.sh MINPORT PORTFILE NEWOWNER

if [ $# -ne 3 ]; then
    echo "Usage: $0 MINPORT PORTFILE NEWOWNER"
    exit 1
fi

MINPORT=$1
PORTFILE=$2
NEWOWNER=$3

COUNT=3   # number of ports to reserve

# Collect used ports
USED=$(awk '{print $1}' "$PORTFILE" | sort -n)

RESERVED=""
FOUND=0
PORT=$MINPORT

while [ $FOUND -lt $COUNT ]; do
    if ! echo "$USED" | grep -qx "$PORT"; then
        RESERVED="$RESERVED $PORT"
        FOUND=$((FOUND + 1))
    fi
    PORT=$((PORT + 1))
done

# Append to file
for P in $RESERVED; do
    echo "$P $NEWOWNER" >> "$PORTFILE"
done

# Assign to variables
set -- $RESERVED
PORT1=$1
PORT2=$2
PORT3=$3

echo "Reserved ports: $PORT1 $PORT2 $PORT3"