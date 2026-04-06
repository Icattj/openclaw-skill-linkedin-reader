---
name: linkedin-reader
description: Read LinkedIn public profiles, company pages, and job listings. Use when asked to look up someone on LinkedIn, research a company's LinkedIn presence, find job listings, or gather professional intelligence. Uses Jina Reader as the primary extraction method.
---

# LinkedIn Reader

Read LinkedIn profiles, companies, and jobs via Jina Reader.

## Quick Start

```bash
# Read a profile
scripts/linkedin.sh "https://linkedin.com/in/username"

# Read a company page
scripts/linkedin.sh "https://linkedin.com/company/dataflow"

# Read a job listing
scripts/linkedin.sh "https://linkedin.com/jobs/view/123456"
```

## How It Works

LinkedIn blocks most scrapers, but Jina Reader can extract public profile content:

```bash
curl -s "https://r.jina.ai/https://www.linkedin.com/in/username"
```

## Limitations

- Only **public profiles** are accessible (profiles with privacy settings may show limited info)
- LinkedIn aggressively blocks automated access — Jina Reader is the most reliable free method
- Rate limit: don't scrape more than a few profiles per minute
- **No search** — LinkedIn search requires authentication
- For heavy LinkedIn research, consider LinkedIn Sales Navigator or a dedicated API

## Alternatives

If Jina Reader fails:
1. **Google cache**: `curl -s "https://r.jina.ai/https://webcache.googleusercontent.com/search?q=cache:linkedin.com/in/username"`
2. **Google search**: `site:linkedin.com/in "person name" "company"`
3. **Browser tool**: For authenticated access when user is logged in

## Search Workaround

Find LinkedIn profiles via Google:
```bash
curl -s "https://s.jina.ai/site:linkedin.com/in+CEO+AI+Indonesia"
```
