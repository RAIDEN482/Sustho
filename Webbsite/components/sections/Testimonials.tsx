"use client";

import { Star } from "lucide-react";
import { useTranslations } from "next-intl";

export default function Testimonials() {
  const t = useTranslations("testimonials");
  const items = t.raw("items") as { quote: string; name: string; meta: string }[];

  return (
    <section className="bg-bg-dark-elevated py-16 sm:py-24">
      <div className="container-shustho">
        <div className="max-w-xl">
          <span className="eyebrow">{t("eyebrow")}</span>
          <h2 className="section-title mt-3">{t("title")}</h2>
        </div>

        <div className="mt-10 grid grid-cols-1 gap-4 sm:grid-cols-3">
          {items.map((item) => (
            <div key={item.name} className="rounded-lg border border-border-dark border-l-[3px] border-l-primary bg-bg-dark p-6">
              <div className="flex gap-0.5 text-warning">
                {Array.from({ length: 5 }).map((_, i) => (
                  <Star key={i} size={14} fill="currentColor" strokeWidth={0} />
                ))}
              </div>
              <p className="mt-4 text-body italic text-text-primary-dark">"{item.quote}"</p>
              <div className="mt-5 flex items-center gap-3">
                <span className="flex h-10 w-10 items-center justify-center rounded-full bg-primary-50/10 text-body-sm text-primary">
                  {item.name[0]}
                </span>
                <div>
                  <p className="text-body-sm text-text-primary-dark">{item.name}</p>
                  <p className="text-caption text-text-tertiary-dark">{item.meta}</p>
                </div>
              </div>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
}
