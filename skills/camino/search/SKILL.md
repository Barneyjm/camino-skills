---
name: search
description: "Direct place search by name or type. Fast, structured lookup without AI processing. Use when you know exactly what you're looking for (e.g., 'Starbucks', 'gas station'). For natural language queries like 'quiet cafes with good wifi', use /query instead."
---

# Search - Direct Place Lookup

Fast, direct place search by name or type. Returns matching places without AI interpretation or ranking.

## Search vs Query

| Feature | `/search` | `/query` |
|---------|-----------|----------|
| Speed | Faster | Slower (AI processing) |
| Input | Exact names/types | Natural language |
| AI Ranking | No | Yes |
| Coordinate Generation | No (required) | Yes (auto-generates for known locations) |
| Answer Generation | No | Yes (optional) |
| Best For | "Starbucks", "pharmacy" | "quiet cafes with good wifi near Times Square" |

**Use `/search`** when you know the exact place name or type.
**Use `/query`** when you need natural language understanding or AI features.

## Setup

1. Get your API key from [https://app.getcamino.ai](https://app.getcamino.ai)
2. Add to your `~/.claude/settings.json`:

```json
{
  "env": {
    "CAMINO_API_KEY": "your-api-key-here"
  }
}
```

3. Restart Claude Code

## Usage

### Via Shell Script

```bash
# Search for a specific place by name
./scripts/search.sh '{"name": "Starbucks", "lat": 40.7589, "lon": -73.9851, "radius": 1000}'

# Search by place type
./scripts/search.sh '{"type": "pharmacy", "lat": 40.7589, "lon": -73.9851, "limit": 10}'

# Search with both name and type
./scripts/search.sh '{"name": "Whole Foods", "type": "supermarket", "lat": 40.7128, "lon": -74.0060}'
```

### Via curl

```bash
curl -H "X-API-Key: $CAMINO_API_KEY" \
  "https://api.getcamino.ai/search?name=Starbucks&lat=40.7589&lon=-73.9851&radius=1000"
```

## Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| name | string | No* | - | Place name to search for (e.g., "Starbucks", "Central Park") |
| type | string | No* | - | OSM place type (e.g., "cafe", "restaurant", "pharmacy", "hotel") |
| lat | float | Yes | - | Latitude for search center |
| lon | float | Yes | - | Longitude for search center |
| radius | int | No | 1000 | Search radius in meters (100-50000) |
| limit | int | No | 20 | Maximum results (1-100) |
| offset | int | No | 0 | Pagination offset |

*At least one of `name` or `type` is required.

## Response Format

```json
{
  "results": [
    {
      "name": "Starbucks",
      "lat": 40.7601,
      "lon": -73.9847,
      "type": "cafe",
      "distance_m": 150,
      "address": "1585 Broadway, New York, NY 10036",
      "osm_id": "node/123456789",
      "tags": {
        "brand": "Starbucks",
        "cuisine": "coffee_shop",
        "opening_hours": "Mo-Fr 06:00-22:00; Sa-Su 07:00-21:00"
      }
    }
  ],
  "pagination": {
    "total_results": 12,
    "limit": 20,
    "offset": 0,
    "has_more": false
  }
}
```

## Common Place Types

| Category | Types |
|----------|-------|
| Food & Drink | cafe, restaurant, bar, pub, fast_food, bakery |
| Shopping | supermarket, convenience, pharmacy, clothes, mall |
| Services | bank, atm, post_office, hospital, clinic |
| Transport | bus_stop, subway_entrance, parking, fuel |
| Accommodation | hotel, hostel, motel, guest_house |
| Leisure | park, gym, cinema, museum, theatre |

## Examples

### Find nearby pharmacies
```bash
./scripts/search.sh '{"type": "pharmacy", "lat": 40.7128, "lon": -74.0060, "radius": 500}'
```

### Find a specific restaurant chain
```bash
./scripts/search.sh '{"name": "Chipotle", "lat": 40.7589, "lon": -73.9851, "limit": 5}'
```

### Find hotels in an area
```bash
./scripts/search.sh '{"type": "hotel", "lat": 48.8566, "lon": 2.3522, "radius": 2000, "limit": 20}'
```

## Best Practices

- Use `/search` for exact matches and known place names/types
- Use `/query` when you need natural language interpretation
- Always provide `lat` and `lon` - search requires explicit coordinates
- Use specific place types for better results (e.g., "cafe" instead of "food")
- Combine `name` and `type` for more precise results
