#!/bin/bash

# Check if user provided file containing IP addresses
if [ $# -ne 1 ]; then
    echo "Usage: $0 <file_containing_ip_addresses>"
    exit 1
fi

# Check if nc (netcat) is installed
if ! [ -x "$(command -v nc)" ]; then
  echo 'Error: netcat (nc) is not installed.' >&2
  exit 1
fi

# Input file containing IP addresses
ip_file=$1

# Check if the file exists
if [ ! -f "$ip_file" ]; then
    echo "Error: $ip_file does not exist."
    exit 1
fi

# Loop through each IP address in the file
while IFS= read -r ip_address; do
    # Attempt to connect to the IP address on port 80 (you can change the port as needed)
    if nc -zv "$ip_address" 80 &> /dev/null; then
        echo "Connection successful to $ip_address"
        # Add your commands here to search for the text file on the server
        # For example:
        # nc "$ip_address" 80 < /path/to/search.txt
    else
        echo "Connection failed to $ip_address"
    fi
done < "$ip_file"
