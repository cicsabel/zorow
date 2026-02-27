#!/bin/bash
# Usage: ./deport.sh PORTFILE OWNER

if [ $# -ne 2 ]; then
    echo "Usage: $0 PORTFILE OWNER"
    exit 1
fi

PORTFILE=$1
OWNER=$2

# Check if file exists
if [ ! -f "$PORTFILE" ]; then
    echo "Error: $PORTFILE does not exist"
    exit 1
fi

# Find ports before deletion
PORTS=$(awk -v owner="$OWNER" '$2 == owner {print $1}' "$PORTFILE")

if [ -z "$PORTS" ]; then
    echo "No ports found for owner $OWNER"
    exit 0
fi

# Remove lines for that owner
grep -v " $OWNER\$" "$PORTFILE" > "$PORTFILE.tmp" && mv "$PORTFILE.tmp" "$PORTFILE"

echo "Deprovisioned ports for $OWNER: $PORTS"
