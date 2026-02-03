# Camino AI Skills

Location intelligence for AI agents. Search for places using natural language, calculate spatial relationships, plan routes and journeys, and get context about locations.

## Installation

```bash
# Install all skills from repo
npx skills add https://github.com/barneyjm/camino-skills

# Or install specific skills
npx skills add https://github.com/barneyjm/camino-skills --skill [query|places|relationship|context|route|journey]

# Or using clawhub:
npx clawhub@latest install [query|places|relationship|context|route|journey]
# pnpm dlx clawhub@latest install [query|places|relationship|context|route|journey]
# bunx clawhub@latest install [query|places|relationship|context|route|journey]
```

```bash
# Install the skills package
npm install @anthropic-ai/claude-code

# Or add skills directly to Claude Code
claude mcp add camino-skills https://github.com/Barneyjm/camino-skills
```

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

## Available Skills

### `/places` - Geocoding & Place Lookup

Locate places using free-form queries or structured address components. Returns coordinates and optional street-level photos.

```bash
# Free-form search
./skills/camino/places/scripts/places.sh '{"query": "Eiffel Tower", "include_photos": true}'

# Structured address
./skills/camino/places/scripts/places.sh '{"street": "350 Fifth Ave", "city": "New York", "state": "NY"}'
```

### `/query` - Natural Language Place Search

Search using natural language with AI ranking and auto-generated coordinates for known locations.

```bash
./skills/camino/query/scripts/query.sh '{"query": "quiet coffee shops with wifi near Times Square", "limit": 5}'
```

#### Places vs Query

| Use `/places` when... | Use `/query` when... |
|-----------------------|----------------------|
| Geocoding addresses | Natural language ("quiet cafes with wifi") |
| Finding specific landmarks | Searching near a location |
| You need street-level photos | You want AI-ranked relevance |

### `/relationship` - Spatial Calculations

Calculate distance, direction, travel time, and descriptions between two points.

```bash
./skills/camino/relationship/scripts/relationship.sh '{
  "start": {"lat": 40.7128, "lon": -74.0060},
  "end": {"lat": 40.7589, "lon": -73.9851}
}'
```

### `/context` - Location Analysis

Get comprehensive context about a location including nearby places and area descriptions.

```bash
./skills/camino/context/scripts/context.sh '{
  "location": {"lat": 40.7589, "lon": -73.9851},
  "radius": 500,
  "context": "lunch options"
}'
```

### `/journey` - Multi-Stop Planning

Plan multi-waypoint journeys with route optimization and feasibility analysis.

```bash
./skills/camino/journey/scripts/journey.sh '{
  "waypoints": [
    {"lat": 40.7128, "lon": -74.0060, "purpose": "Start"},
    {"lat": 40.7484, "lon": -73.9857, "purpose": "Empire State"},
    {"lat": 40.7614, "lon": -73.9776, "purpose": "Lunch"}
  ],
  "constraints": {"transport": "foot", "time_budget": "3 hours"}
}'
```

### `/route` - Point-to-Point Navigation

Get detailed routing with turn-by-turn directions between two points.

```bash
./skills/camino/route/scripts/route.sh '{
  "start_lat": 40.7128,
  "start_lon": -74.0060,
  "end_lat": 40.7589,
  "end_lon": -73.9851,
  "mode": "foot"
}'
```

### `/relationship` - Point-to-Point Navigation

Calculate spatial relationships between two points including distance, direction, travel time, and human-readable descriptions.

```bash
# Calculate relationship between two points
./scripts/relationship.sh '{
  "start": {"lat": 40.7128, "lon": -74.0060},
  "end": {"lat": 40.7589, "lon": -73.9851}
}'

# Include specific calculations
./scripts/relationship.sh '{
  "start": {"lat": 40.7128, "lon": -74.0060},
  "end": {"lat": 40.7589, "lon": -73.9851},
  "include": ["distance", "direction", "travel_time", "description"]
}'
```

## Free Tier

- 1,000 API calls per month
- All endpoints included
- No credit card required

## Rate Limits

| Tier | Rate Limit | Monthly Calls | Price |
|------|------------|---------------|-------|
| Free | 30/minute | 1,000 | $0 |
| Pay-as-you-go | 60/minute | Unlimited | $0.001/call |
| Enterprise | Custom | Custom | Contact sales |

## Documentation

- Full API docs: [https://docs.getcamino.ai](https://docs.getcamino.ai)
- Dashboard: [https://app.getcamino.ai](https://app.getcamino.ai)
- Support: hello@getcamino.ai

## License

MIT
