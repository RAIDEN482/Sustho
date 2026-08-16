# Shustho — website

Next.js 14 (App Router) + TypeScript + Tailwind, built from the Shustho design
tokens and website prompt. **Scope: marketing/landing website only — no app
screens (dashboard, calendar, log, insights, etc. are intentionally excluded
per current direction).**

Verified with a clean production build (`npx next build`, both `/en` and
`/bn` prerender statically) in this environment except for the live Google
Fonts fetch, which this sandbox's network blocks — it resolves normally
wherever you run it with regular internet access.

## Run it

```bash
npm install
npm run dev       # http://localhost:3000 → redirects to /en
npm run build && npm start   # production build
```

## What's built

- **Landing page** (`app/[locale]/page.tsx`) — all 11 sections from the
  prompt: hero, features grid, how-it-works timeline, live dashboard preview
  (real Recharts charts, presented as a static marketing preview — no link
  into a functional app), PCOS/conditions tabs, guardian feature,
  testimonials, doctor network (with live city filter), pricing, FAQ
  accordion, footer.
- **Design tokens** — every color, type scale, spacing, radius, and duration
  value from `design_system_tokens.pdf` is wired into `tailwind.config.ts`
  and `app/globals.css` exactly (flat design, no shadows, outlined 1.8px
  Lucide icons, tabular-nums, sentence case, weights 400/500 only).
- **Full Bangla + English localization** via `next-intl`:
  - `/en` and `/bn` routes with locale-aware middleware
  - Every section pulls copy from `messages/en.json` / `messages/bn.json`
  - Bengali headline in the hero renders in Noto Sans Bengali; the
    language toggle in the nav and footer switches locale in place
- **SEO** — per-locale metadata, Open Graph tags, a dynamically generated OG
  image (`app/[locale]/opengraph-image.tsx`, no external asset needed),
  Twitter card, `HealthApplication` JSON-LD structured data, `robots.txt`,
  and `sitemap.xml` covering both locales.
- **PWA manifest** (`public/manifest.json`).

## What's not built (out of scope per current direction)

The original prompt also specs a full functional PWA app on top of the
marketing site. That's intentionally excluded right now:

- `/onboarding`, `/dashboard`, `/calendar`, `/log`, `/insights`, `/health`,
  `/guardian`, `/settings` — none of these app screens exist in this build
- IndexedDB/Zustand data layer, service worker/offline caching, PDF/CSV
  export — all app-layer concerns, not built

## Still open on the marketing side (if you want them next)

- App icons (`/public/icon-192.png`, `/public/icon-512.png` — referenced in
  the manifest but not generated)
- Real hospital dataset beyond the 3 sample entries in `DoctorNetwork.tsx`
- Real screenshots/mockups in the presentation-slide sense (the design
  system PDF's slide-deck section) — not part of the website itself

## Structure

```
app/
  [locale]/
    layout.tsx          per-locale layout, fonts, JSON-LD, metadata
    page.tsx              landing page
    opengraph-image.tsx    dynamic OG image (next/og)
  globals.css            tokens as Tailwind + base styles
  robots.ts / sitemap.ts
components/
  Nav.tsx, Footer.tsx      locale-aware (language switch, translated links)
  sections/                 one component per landing section, all i18n-wired
i18n/
  routing.ts, navigation.ts, request.ts    next-intl config
messages/
  en.json, bn.json         all copy, both languages
middleware.ts               locale detection/redirect
public/manifest.json
tailwind.config.ts           full design-token mapping
```

