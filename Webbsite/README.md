# Shustho — website

Next.js 14 (App Router) + TypeScript + Tailwind, built from the Shustho design
tokens and website prompt. Verified with a clean production build
(`npx next build`) in this environment except for the Google Fonts fetch,
which this sandbox blocks — it will resolve normally wherever you run it with
regular internet access.

## Run it

```bash
npm install
npm run dev       # http://localhost:3000
npm run build && npm start   # production build
```

## What's built

- **Landing page** (`app/page.tsx`) — all 11 sections from the prompt: hero,
  features grid, how-it-works timeline, live dashboard preview (real Recharts
  charts), PCOS/conditions tabs, guardian feature, testimonials, doctor
  network (with live city filter), pricing, FAQ accordion, footer.
- **Design tokens** — every color, type scale, spacing, radius, and duration
  value from `design_system_tokens.pdf` is wired into `tailwind.config.ts`
  and `app/globals.css` exactly (flat design, no shadows, outlined 1.8px
  Lucide icons, tabular-nums, sentence case, weights 400/500 only).
- **`/dashboard`** — the first functional PWA app screen (cycle status,
  quick actions, prediction card, alert banner, today's summary, bottom nav).
- **PWA manifest** (`public/manifest.json`).

## What's not built yet

The prompt specs 7 more functional app screens beyond the dashboard. These
weren't built in this pass:

- `/onboarding` — auth/language/health-conditions setup flow
- `/calendar` — month calendar with day detail panel
- `/log` — the 5-tab logging form (period/flow/pain/mood/nutrition)
- `/insights` — cycle/pain/mood charts + PDF/CSV export
- `/health` — conditions list, alert history, doctor report generator
- `/guardian` — guardian management + activity log
- `/settings` — profile, language, notifications, privacy, data export

Also not yet wired up:
- Bangla (`bn`) translations and `next-intl` locale routing (nav/footer have
  toggle UI, but it doesn't switch content yet)
- IndexedDB/Zustand data layer (currently all screens show static mock data)
- Service worker / offline caching (`next-pwa`)
- App icons (`/public/icon-192.png`, `/public/icon-512.png` — placeholders
  referenced in the manifest but not generated)
- Real hospital dataset beyond the 3 sample entries

## Structure

```
app/
  layout.tsx          root layout, Inter font, metadata
  page.tsx             landing page
  globals.css          tokens as Tailwind + base styles
  dashboard/page.tsx    functional dashboard screen
components/
  Nav.tsx, Footer.tsx
  sections/             one component per landing section
public/manifest.json
tailwind.config.ts       full design-token mapping
```
