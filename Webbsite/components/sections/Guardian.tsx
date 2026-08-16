"use client";

import { ShieldCheck } from "lucide-react";
import { useTranslations } from "next-intl";

export default function Guardian() {
  const t = useTranslations("guardian");
  const toggles = t.raw("toggles") as string[];

  return (
    <section className="bg-bg-dark py-16 sm:py-24">
      <div className="container-shustho grid grid-cols-1 items-center gap-10 lg:grid-cols-2">
        <div>
          <span className="eyebrow text-secondary">{t("eyebrow")}</span>
          <h2 className="section-title mt-3">{t("title")}</h2>
          <p className="mt-4 text-body text-text-secondary-dark">{t("desc")}</p>

          <div className="mt-6 space-y-3">
            {toggles.map((label, i) => (
              <div key={label} className="flex items-center justify-between rounded-md border border-border-dark bg-bg-dark-muted px-4 py-3">
                <span className="text-body-sm text-text-primary-dark">{label}</span>
                <span
                  className={`relative h-6 w-11 rounded-full transition-colors duration-normal ${
                    i < 2 ? "bg-secondary" : "bg-bg-dark-elevated border border-border-dark"
                  }`}
                >
                  <span
                    className={`absolute top-0.5 h-5 w-5 rounded-full bg-white transition-transform duration-normal ${
                      i < 2 ? "translate-x-5" : "translate-x-0.5"
                    }`}
                  />
                </span>
              </div>
            ))}
          </div>

          <p className="mt-4 flex items-center gap-2 text-body-sm text-secondary">
            <ShieldCheck size={18} strokeWidth={1.8} />
            {t("controlNote")}
          </p>
        </div>

        <div className="rounded-2xl border border-secondary bg-bg-dark-elevated p-5">
          <span className="eyebrow text-secondary">{t("previewLabel")}</span>
          <div className="mt-4 space-y-3">
            <div className="rounded-md border-l-[3px] border-secondary bg-secondary-50/10 px-4 py-3 text-body-sm text-text-primary-dark">
              {t("previewLine1")}
            </div>
            <div className="rounded-md border-l-[3px] border-danger bg-danger-50/10 px-4 py-3 text-body-sm text-danger">
              {t("previewLine2")}
            </div>
            <div className="rounded-md border-l-[3px] border-warning bg-warning-50/10 px-4 py-3 text-body-sm text-warning">
              {t("previewLine3")}
            </div>
            <div className="ml-6 rounded-lg bg-bg-dark-muted px-4 py-3 text-body-sm text-text-secondary-dark">
              "{t("previewReply")}"
            </div>
          </div>
        </div>
      </div>
    </section>
  );
}
