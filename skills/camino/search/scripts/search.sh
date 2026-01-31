#!/bin/bash
# Camino AI Search API - Direct Place Lookup
# Usage: ./search.sh '{"name": "Starbucks", "lat": 40.7589, "lon": -73.9851}'

set -e

# Check if input is provided
if [ -z "$1" ]; then
    echo "Error: JSON input required" >&2
    echo "Usage: ./search.sh '{\"name\": \"Starbucks\", \"lat\": 40.7589, \"lon\": -73.9851}'" >&2
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

# Check for required fields
NAME=$(echo "$INPUT" | jq -r '.name // empty')
TYPE=$(echo "$INPUT" | jq -r '.type // empty')
LAT=$(echo "$INPUT" | jq -r '.lat // empty')
LON=$(echo "$INPUT" | jq -r '.lon // empty')

if [ -z "$NAME" ] && [ -z "$TYPE" ]; then
    echo "Error: At least one of 'name' or 'type' is required" >&2
    exit 1
fi

if [ -z "$LAT" ] || [ -z "$LON" ]; then
    echo "Error: 'lat' and 'lon' are required for search" >&2
    echo "Hint: Use /query instead if you want AI to generate coordinates" >&2
    exit 1
fi

# Build query string from JSON input
build_query_string() {
    local params="lat=${LAT}&lon=${LON}"

    # Optional name and type
    [ -n "$NAME" ] && params="${params}&name=$(echo "$NAME" | jq -sRr @uri)"
    [ -n "$TYPE" ] && params="${params}&type=$(echo "$TYPE" | jq -sRr @uri)"

    # Other optional parameters
    local radius=$(echo "$INPUT" | jq -r '.radius // empty')
    local limit=$(echo "$INPUT" | jq -r '.limit // empty')
    local offset=$(echo "$INPUT" | jq -r '.offset // empty')

    [ -n "$radius" ] && params="${params}&radius=${radius}"
    [ -n "$limit" ] && params="${params}&limit=${limit}"
    [ -n "$offset" ] && params="${params}&offset=${offset}"

    echo "$params"
}

QUERY_STRING=$(build_query_string)

# Make API request
curl -s -X GET \
    -H "X-API-Key: $CAMINO_API_KEY" \
    -H "X-Client: claude-code-skill" \
    "https://api.getcamino.ai/search?${QUERY_STRING}" | jq .
