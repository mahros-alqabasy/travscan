#!/bin/bash

source "$(dirname "$0")/lib/utils.sh"
source "$(dirname "$0")/lib/payloads.sh"

TARGET_URL="$1"
LOG_DIR="./output/logs"
mkdir -p "$LOG_DIR"

if [[ -z "$TARGET_URL" ]]; then
  echo "Usage: $0 <target_url>"
  echo "Example: $0 http://example.com/download?file="
  exit 1
fi

echo "[+] Starting directory traversal scan on: $TARGET_URL"
echo "[+] Payloads loaded: ${#PAYLOADS[@]}"

for payload in "${PAYLOADS[@]}"; do
  full_url="${TARGET_URL}${payload}"
  response=$(curl -s -o /tmp/travscan_response.txt -w "%{http_code}" "$full_url")
  content=$(cat /tmp/travscan_response.txt)

  if [[ "$response" =~ ^2[0-9]{2}$ ]] && grep -q "root:" <<< "$content"; then
    echo -e "[!!] Potential Vulnerability Detected: $full_url"
    log_vulnerability "$full_url" "$response"
  else
    echo "[-] Checked: $full_url"
  fi
done

echo "[+] Scan completed. Logs saved in $LOG_DIR."
