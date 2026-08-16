import type { Metadata } from "next";
import { Inter, Noto_Sans_Bengali } from "next/font/google";
import { NextIntlClientProvider, hasLocale } from "next-intl";
import { notFound } from "next/navigation";
import { routing } from "@/i18n/routing";
import "../globals.css";

const inter = Inter({
  subsets: ["latin"],
  weight: ["400", "500"],
  variable: "--font-inter",
  display: "swap",
});

const notoBengali = Noto_Sans_Bengali({
  subsets: ["bengali"],
  weight: ["400", "500"],
  variable: "--font-bengali",
  display: "swap",
});

export const metadata: Metadata = {
  metadataBase: new URL("https://shustho.app"),
  title: "Shustho — Free period & health tracker for Bangladesh",
  description:
    "Track your menstrual cycle, manage PCOS symptoms, and share health updates with trusted guardians. 100% free, offline-first, and private.",
  manifest: "/manifest.json",
  openGraph: {
    title: "Shustho — Free period & health tracker for Bangladesh",
    description:
      "Track your menstrual cycle, manage PCOS symptoms, and share health updates with trusted guardians. 100% free, offline-first, and private.",
    type: "website",
    images: ["/opengraph-image"],
  },
  twitter: { card: "summary_large_image" },
};

export function generateStaticParams() {
  return routing.locales.map((locale) => ({ locale }));
}

export default async function LocaleLayout({
  children,
  params,
}: {
  children: React.ReactNode;
  params: Promise<{ locale: string }>;
}) {
  const { locale } = await params;
  if (!hasLocale(routing.locales, locale)) {
    notFound();
  }

  const jsonLd = {
    "@context": "https://schema.org",
    "@type": "HealthApplication",
    name: "Shustho",
    applicationCategory: "HealthApplication",
    operatingSystem: "Web, Android, iOS",
    offers: { "@type": "Offer", price: "0", priceCurrency: "USD" },
    description:
      "Free, offline-first period and reproductive health tracker for Bangladesh.",
  };

  return (
    <html
      lang={locale}
      dir="ltr"
      className={`dark ${inter.variable} ${notoBengali.variable}`}
    >
      <body className={locale === "bn" ? "font-bengali" : "font-sans"}>
        <script
          type="application/ld+json"
          dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd) }}
        />
        <NextIntlClientProvider>{children}</NextIntlClientProvider>
      </body>
    </html>
  );
}
