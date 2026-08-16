"use client";

import { CheckCircle2 } from "lucide-react";
import { useTranslations } from "next-intl";

export default function Pricing() {
  const t = useTranslations("pricing");
  const perks = t.raw("perks") as string[];

  return (
    <section id="pricing" className="bg-bg-dark-elevated py-16 sm:py-24">
      <div className="container-shustho flex flex-col items-center text-center">
        <span className="eyebrow">{t("eyebrow")}</span>
        <h2 className="section-title mt-3">{t("title")}</h2>

        <div className="mt-10 w-full max-w-md rounded-2xl border border-border-dark bg-bg-dark p-8">
          <CheckCircle2 size={64} strokeWidth={1.8} className="mx-auto text-success" />
          <p className="mt-4 text-display text-text-primary-dark">{t("price")}</p>

          <ul className="mt-6 space-y-2 text-left">
            {perks.map((p) => (
              <li key={p} className="flex items-center gap-2 text-body-sm text-text-secondary-dark">
                <CheckCircle2 size={16} strokeWidth={1.8} className="shrink-0 text-success" />
                {p}
              </li>
            ))}
          </ul>

          <a href="#" className="btn-primary mt-8 w-full">
            {t("cta")}
          </a>
          <p className="mt-3 text-caption text-text-tertiary-dark">{t("note")}</p>
        </div>
      </div>
    </section>
  );
}
