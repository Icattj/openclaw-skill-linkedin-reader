#!/usr/bin/env bash
# Read LinkedIn profiles/pages via Jina Reader
# Usage: linkedin.sh <linkedin-url-or-username>
set -euo pipefail

INPUT="${1:?Usage: linkedin.sh <linkedin-url-or-username>}"

# If just a username, construct the profile URL
if [[ ! "$INPUT" =~ ^https?:// ]]; then
    INPUT="https://www.linkedin.com/in/$INPUT"
fi

# Ensure www prefix for LinkedIn
INPUT=$(echo "$INPUT" | sed 's|linkedin.com|www.linkedin.com|' | sed 's|www.www.|www.|')

echo "👤 Reading LinkedIn: $INPUT"
echo ""

RESPONSE=$(curl -sL --max-time 30 \
    -H "Accept: text/markdown" \
    "https://r.jina.ai/$INPUT" 2>/dev/null)

if [ -z "$RESPONSE" ] || echo "$RESPONSE" | grep -qi "sign in\|authwall\|join now"; then
    echo "⚠️  LinkedIn returned an auth wall. Profile may be private."
    echo ""
    echo "Trying Google cache fallback..."
    ENCODED=$(python3 -c "import urllib.parse; print(urllib.parse.quote('$INPUT'))")
    RESPONSE=$(curl -sL --max-time 30 "https://r.jina.ai/https://webcache.googleusercontent.com/search?q=cache:$ENCODED" 2>/dev/null)
fi

if [ -z "$RESPONSE" ]; then
    echo "❌ Could not retrieve LinkedIn content."
    echo "Try: Google search with site:linkedin.com"
    exit 1
fi

echo "$RESPONSE"
