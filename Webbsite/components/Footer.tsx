"use client";

import { Heart, Mail, MessageCircle, Facebook } from "lucide-react";
import { useTranslations, useLocale } from "next-intl";
import { Link, usePathname } from "@/i18n/navigation";

export default function Footer() {
  const t = useTranslations("footer");
  const tNav = useTranslations("nav");
  const locale = useLocale();
  const pathname = usePathname();
  const otherLocale = locale === "en" ? "bn" : "en";

  return (
    <footer className="bg-bg-dark border-t border-border-dark">
      <div className="container-shustho grid grid-cols-1 gap-10 py-16 sm:grid-cols-2 lg:grid-cols-4">
        <div>
          <div className="flex items-center gap-2">
            <span className="flex h-8 w-8 items-center justify-center rounded-md bg-primary">
              <Heart size={18} strokeWidth={1.8} className="text-white" />
            </span>
            <span className="text-h4 text-text-primary-dark">Shustho</span>
          </div>
          <p className="mt-3 max-w-[220px] text-body-sm text-text-secondary-dark">
            {t("tagline")}
          </p>
        </div>

        <div>
          <h4 className="text-h4 text-text-primary-dark">{t("quickLinks")}</h4>
          <ul className="mt-4 space-y-2 text-body-sm text-text-secondary-dark">
            <li><a href="#features">{tNav("features")}</a></li>
            <li><a href="#how-it-works">{tNav("howItWorks")}</a></li>
            <li><a href="#doctors">{tNav("doctors")}</a></li>
            <li><a href="#faq">{tNav("faq")}</a></li>
          </ul>
        </div>

        <div>
          <h4 className="text-h4 text-text-primary-dark">{t("legal")}</h4>
          <ul className="mt-4 space-y-2 text-body-sm text-text-secondary-dark">
            <li><a href="#">{t("privacy")}</a></li>
            <li><a href="#">{t("terms")}</a></li>
            <li><a href="#">{t("dataPolicy")}</a></li>
          </ul>
        </div>

        <div>
          <h4 className="text-h4 text-text-primary-dark">{t("connect")}</h4>
          <div className="mt-4 flex gap-4 text-text-secondary-dark">
            <a href="mailto:hello@shustho.app" aria-label="Email"><Mail size={20} strokeWidth={1.8} /></a>
            <a href="#" aria-label="WhatsApp"><MessageCircle size={20} strokeWidth={1.8} /></a>
            <a href="#" aria-label="Facebook"><Facebook size={20} strokeWidth={1.8} /></a>
          </div>
        </div>
      </div>

      <div className="border-t border-border-dark">
        <div className="container-shustho flex flex-col items-center justify-between gap-3 py-6 sm:flex-row">
          <p className="text-caption text-text-tertiary-dark">© {new Date().getFullYear()} Shustho. {t("rights")}</p>
          <Link href={pathname} locale={otherLocale} className="text-caption text-text-tertiary-dark">
            {otherLocale === "bn" ? "বাংলা" : "English"}
          </Link>
        </div>
      </div>
    </footer>
  );
}
