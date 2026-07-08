# BoBoApp Web Deployment

This folder publishes the current BoBo English prototype at:

```text
https://dasheng1999-ui.github.io/hong-kong-english-app/bobo/
```

## Current Login Mode

This version uses browser `localStorage`.

- Admin account: `admin`
- Default admin password: `bobo2026`
- Student accounts created in the admin panel are stored only in the current browser/device.
- Progress and device binding are also local to the browser/device.

This is enough for web preview and demo access, but not enough for real paid users across devices.

## Production Backend Needed Later

For real cloud login, shared account management, paid access, and synced progress, migrate these local records to a backend such as Supabase:

- users
- licenses
- devices
- user progress
- review queues
- payments/subscriptions

