
file="compose.yml"
file_content=$(<"$file")
ports=$(awk '/ports:/{getline; print $2}' <<< "$file_content")
IFS=: read -r port1 port2 <<< "$ports" || { echo "Error: Invalid port format"; exit 1; }
echo
echo "  URL: http://localhost:$port1"