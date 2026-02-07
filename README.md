# Camino AI Skills

Location intelligence for AI agents. Search for places using natural language, calculate spatial relationships, plan routes and journeys, and get context about locations.

## Installation

```bash
# Install all skills from repo
npx skills add https://github.com/barneyjm/camino-skills

# Or install specific skills
npx skills add https://github.com/barneyjm/camino-skills --skill [skill-name]

# Or using clawhub:
npx clawhub@latest install [skill-name]
# pnpm dlx clawhub@latest install [skill-name]
# bunx clawhub@latest install [skill-name]
```

## Setup

**Instant Trial (no signup required):** Get a temporary API key with 25 calls:

```bash
curl -s -X POST -H "Content-Type: application/json" \
  -d '{"email": "you@example.com"}' \
  https://api.getcamino.ai/trial/start
```

Returns: `{"api_key": "camino-xxx...", "calls_remaining": 25, ...}`

For 1,000 free calls/month, sign up at [https://app.getcamino.ai/skills/activate](https://app.getcamino.ai/skills/activate).

**Add your key to Claude Code:**

Add to your `~/.claude/settings.json`:

```json
{
  "env": {
    "CAMINO_API_KEY": "your-api-key-here"
  }
}
```

Restart Claude Code.

## Available Skills

### Core Skills

The 6 foundational primitives that map directly to the Camino API — search, geocode, measure, analyze, route, and plan.

| Skill | Description | Example |
|-------|-------------|---------|
| `/query` | Natural language place search with AI ranking | `"quiet coffee shops with wifi near Times Square"` |
| `/places` | Geocoding & place lookup with optional street-level photos | `"Eiffel Tower"` or structured address components |
| `/relationship` | Distance, direction, and travel time between two points | Calculate commute time between home and office |
| `/context` | Location analysis with nearby places and area description | Understand what's around a destination |
| `/route` | Point-to-point navigation with turn-by-turn directions | Walking directions from hotel to conference |
| `/journey` | Multi-stop trip planning with route optimization | Plan a 3-hour walking tour of Paris landmarks |

### Composite Skills

Opinionated workflows built on top of the core primitives. Each one combines multiple core skills (query, context, route, etc.) into a single purpose-built command.

| Skill | Description | Example |
|-------|-------------|---------|
| `/real-estate` | Evaluate addresses for home buyers and renters | `"Evaluate 350 Fifth Ave, New York for walkability and schools"` |
| `/hotel-finder` | Search for hotels and lodging near landmarks or venues | `"Hotels near the convention center in Austin"` |
| `/ev-charger` | Find EV charging stations along a route or near a destination | `"EV chargers near SFO airport"` |
| `/school-finder` | Locate schools and universities near any address | `"Elementary schools within 1 mile of 123 Oak St, Palo Alto"` |
| `/parking-finder` | Find parking garages, lots, and street parking | `"Parking near Madison Square Garden"` |
| `/fitness-finder` | Search for gyms, yoga studios, pools, and sports facilities | `"Yoga studios near downtown Denver"` |
| `/safety-checker` | Find 24-hour businesses, transit, police, and hospitals for late-night safety | `"Safe well-lit areas near Penn Station at midnight"` |
| `/travel-planner` | Plan day trips, walking tours, and multi-stop itineraries | `"Plan a 6-hour walking tour of Rome"` |

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
