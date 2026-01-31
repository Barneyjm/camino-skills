#!/bin/bash
# Camino AI Query API - Natural Language Place Search
# Usage: ./query.sh '{"query": "coffee shops near Times Square", "limit": 5}'

set -e

# Check if input is provided
if [ -z "$1" ]; then
    echo "Error: JSON input required" >&2
    echo "Usage: ./query.sh '{\"query\": \"coffee shops\", \"lat\": 40.7589, \"lon\": -73.9851}'" >&2
    exit 1
fi

INPUT="$1"

# Validate JSON
if ! echo "$INPUT" | jq empty 2>/dev/null; then
    echo "Error: Invalid JSON input" >&2
    exit 1
fi

# Check for API key
if [ -z "$CAMINO_API_KEY" ]; then
    echo "Error: CAMINO_API_KEY environment variable not set" >&2
    echo "Get your API key at https://app.getcamino.ai" >&2
    exit 1
fi

# Check for required field (query or osm_ids)
QUERY=$(echo "$INPUT" | jq -r '.query // empty')
OSM_IDS=$(echo "$INPUT" | jq -r '.osm_ids // empty')

if [ -z "$QUERY" ] && [ -z "$OSM_IDS" ]; then
    echo "Error: 'query' or 'osm_ids' field is required" >&2
    exit 1
fi

# Build query string from JSON input
build_query_string() {
    local params=""

    # Required/main parameters
    [ -n "$QUERY" ] && params="${params}&query=$(echo "$QUERY" | jq -sRr @uri)"
    [ -n "$OSM_IDS" ] && params="${params}&osm_ids=$(echo "$OSM_IDS" | jq -sRr @uri)"

    # Optional parameters
    local lat=$(echo "$INPUT" | jq -r '.lat // empty')
    local lon=$(echo "$INPUT" | jq -r '.lon // empty')
    local radius=$(echo "$INPUT" | jq -r '.radius // empty')
    local rank=$(echo "$INPUT" | jq -r '.rank // empty')
    local limit=$(echo "$INPUT" | jq -r '.limit // empty')
    local offset=$(echo "$INPUT" | jq -r '.offset // empty')
    local answer=$(echo "$INPUT" | jq -r '.answer // empty')
    local time=$(echo "$INPUT" | jq -r '.time // empty')
    local mode=$(echo "$INPUT" | jq -r '.mode // empty')

    [ -n "$lat" ] && params="${params}&lat=${lat}"
    [ -n "$lon" ] && params="${params}&lon=${lon}"
    [ -n "$radius" ] && params="${params}&radius=${radius}"
    [ -n "$rank" ] && params="${params}&rank=${rank}"
    [ -n "$limit" ] && params="${params}&limit=${limit}"
    [ -n "$offset" ] && params="${params}&offset=${offset}"
    [ -n "$answer" ] && params="${params}&answer=${answer}"
    [ -n "$time" ] && params="${params}&time=$(echo "$time" | jq -sRr @uri)"
    [ -n "$mode" ] && params="${params}&mode=${mode}"

    # Remove leading &
    echo "${params:1}"
}

QUERY_STRING=$(build_query_string)

# Make API request
curl -s -X GET \
    -H "X-API-Key: $CAMINO_API_KEY" \
    -H "X-Client: claude-code-skill" \
    "https://api.getcamino.ai/query?${QUERY_STRING}" | jq .
