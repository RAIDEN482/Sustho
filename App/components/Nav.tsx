"use client";

import { useState } from "react";
import { Menu, X, Heart } from "lucide-react";
import { useTranslations, useLocale } from "next-intl";
import { Link, usePathname } from "@/i18n/navigation";

export default function Nav() {
  const [open, setOpen] = useState(false);
  const t = useTranslations("nav");
  const locale = useLocale();
  const pathname = usePathname();
  const otherLocale = locale === "en" ? "bn" : "en";

  const links = [
    { label: t("features"), href: "#features" },
    { label: t("howItWorks"), href: "#how-it-works" },
    { label: t("doctors"), href: "#doctors" },
    { label: t("faq"), href: "#faq" },
  ];

  return (
    <header className="sticky top-0 z-50 border-b border-border-dark bg-bg-dark/90 backdrop-blur">
      <div className="container-shustho flex h-16 items-center justify-between">
        <a href="#" className="flex items-center gap-2">
          <span className="flex h-8 w-8 items-center justify-center rounded-md bg-primary">
            <Heart size={18} strokeWidth={1.8} className="text-white" />
          </span>
          <span className="text-h4 text-text-primary-dark">Shustho</span>
        </a>

        <nav className="hidden items-center gap-8 md:flex">
          {links.map((l) => (
            <a
              key={l.href}
              href={l.href}
              className="text-body-sm text-text-secondary-dark transition-colors duration-normal hover:text-text-primary-dark"
            >
              {l.label}
            </a>
          ))}
        </nav>

        <div className="hidden items-center gap-3 md:flex">
          <Link
            href={pathname}
            locale={otherLocale}
            className="text-body-sm text-text-secondary-dark transition-colors duration-normal hover:text-text-primary-dark"
          >
            {t("langSwitch")}
          </Link>
          <a href="#pricing" className="btn-primary">
            {t("download")}
          </a>
        </div>

        <button
          className="md:hidden text-text-primary-dark"
          aria-label="Toggle menu"
          onClick={() => setOpen(!open)}
        >
          {open ? <X size={24} strokeWidth={1.8} /> : <Menu size={24} strokeWidth={1.8} />}
        </button>
      </div>

      {open && (
        <div className="border-t border-border-dark bg-bg-dark md:hidden">
          <div className="container-shustho flex flex-col gap-4 py-4">
            {links.map((l) => (
              <a key={l.href} href={l.href} className="text-body text-text-secondary-dark">
                {l.label}
              </a>
            ))}
            <Link href={pathname} locale={otherLocale} className="text-body text-text-secondary-dark">
              {t("langSwitch")}
            </Link>
            <a href="#pricing" className="btn-primary w-full">
              {t("download")}
            </a>
          </div>
        </div>
      )}
    </header>
  );
}
