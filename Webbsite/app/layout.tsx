import type { Metadata } from "next";
import { Inter } from "next/font/google";
import "./globals.css";

const inter = Inter({
  subsets: ["latin"],
  weight: ["400", "500"],
  variable: "--font-inter",
  display: "swap",
});

export const metadata: Metadata = {
  title: "Shustho — Free period & health tracker for Bangladesh",
  description:
    "Track your menstrual cycle, manage PCOS symptoms, and share health updates with trusted guardians. 100% free, offline-first, and private.",
  manifest: "/manifest.json",
  openGraph: {
    title: "Shustho — Free period & health tracker for Bangladesh",
    description:
      "Track your menstrual cycle, manage PCOS symptoms, and share health updates with trusted guardians. 100% free, offline-first, and private.",
    images: ["/og-image.png"],
  },
  twitter: { card: "summary_large_image" },
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en" className={`dark ${inter.variable}`}>
      <body className="font-sans">{children}</body>
    </html>
  );
}
