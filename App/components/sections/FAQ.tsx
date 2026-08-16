"use client";

import { useState } from "react";
import { ChevronDown } from "lucide-react";
import { useTranslations } from "next-intl";

export default function FAQ() {
  const t = useTranslations("faq");
  const [openIndex, setOpenIndex] = useState<number | null>(0);
  const items = t.raw("items") as { q: string; a: string }[];

  return (
    <section id="faq" className="bg-bg-dark py-16 sm:py-24">
      <div className="container-shustho max-w-2xl">
        <span className="eyebrow">{t("eyebrow")}</span>
        <h2 className="section-title mt-3">{t("title")}</h2>

        <div className="mt-8 divide-y divide-border-dark border-y border-border-dark">
          {items.map((f, i) => {
            const isOpen = openIndex === i;
            return (
              <div key={f.q}>
                <button
                  onClick={() => setOpenIndex(isOpen ? null : i)}
                  className="flex w-full items-center justify-between py-4 text-left"
                  aria-expanded={isOpen}
                >
                  <span className="text-h4 text-text-primary-dark">{f.q}</span>
                  <ChevronDown
                    size={20}
                    strokeWidth={1.8}
                    className={`shrink-0 text-text-tertiary-dark transition-transform duration-normal ${
                      isOpen ? "rotate-180" : ""
                    }`}
                  />
                </button>
                {isOpen && (
                  <p className="pb-4 text-body-sm text-text-secondary-dark">{f.a}</p>
                )}
              </div>
            );
          })}
        </div>
      </div>
    </section>
  );
}
