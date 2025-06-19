#!/bin/bash

log_vulnerability() {
  local url="$1"
  local status="$2"
  local ts=$(date "+%Y%m%d-%H%M%S")
  echo "$ts | $status | $url" >> "./output/logs/travscan.log"
}
