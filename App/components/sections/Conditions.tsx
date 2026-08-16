"use client";

import { useState } from "react";
import { useTranslations } from "next-intl";

export default function Conditions() {
  const t = useTranslations("conditions");
  const [active, setActive] = useState(0);
  const items = t.raw("items") as { name: string; desc: string; tracks: string[] }[];
  const c = items[active];

  return (
    <section className="bg-bg-dark-elevated py-16 sm:py-24">
      <div className="container-shustho">
        <div className="max-w-xl">
          <span className="eyebrow text-success">{t("eyebrow")}</span>
          <h2 className="section-title mt-3">{t("title")}</h2>
        </div>

        <div className="mt-8 flex gap-2 overflow-x-auto pb-2">
          {items.map((item, i) => (
            <button
              key={item.name}
              onClick={() => setActive(i)}
              className={`whitespace-nowrap rounded-sm px-4 py-2 text-body-sm transition-colors duration-normal ${
                i === active
                  ? "bg-success/15 text-success border border-success"
                  : "border border-border-dark text-text-secondary-dark hover:text-text-primary-dark"
              }`}
            >
              {item.name}
            </button>
          ))}
        </div>

        <div className="mt-6 rounded-lg border border-border-dark bg-bg-dark p-6">
          <h3 className="text-h3 text-text-primary-dark">{c.name}</h3>
          <p className="mt-2 max-w-2xl text-body text-text-secondary-dark">{c.desc}</p>
          <ul className="mt-4 grid grid-cols-1 gap-2 sm:grid-cols-2">
            {c.tracks.map((tr) => (
              <li key={tr} className="flex items-center gap-2 text-body-sm text-text-secondary-dark">
                <span className="h-1.5 w-1.5 rounded-full bg-success" />
                {tr}
              </li>
            ))}
          </ul>
          <a href="#faq" className="mt-4 inline-block text-body-sm text-success">
            {t("learnMore")} →
          </a>
        </div>
      </div>
    </section>
  );
}
