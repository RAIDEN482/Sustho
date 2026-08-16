"use client";

import { ChevronDown } from "lucide-react";
import { useTranslations } from "next-intl";
import { motion } from "framer-motion";

export default function Hero() {
  const t = useTranslations("hero");

  return (
    <section className="relative overflow-hidden bg-bg-dark">
      {/* Abstract cycle visualization — pink to blue gradient shapes, no stock photos */}
      <div
        aria-hidden
        className="pointer-events-none absolute -right-40 -top-40 h-[520px] w-[520px] rounded-full opacity-30 blur-3xl"
        style={{
          background: "radial-gradient(circle, #E94560 0%, #58A6FF 100%)",
        }}
      />
      <div
        aria-hidden
        className="pointer-events-none absolute -left-32 bottom-0 h-[360px] w-[360px] rounded-full opacity-20 blur-3xl"
        style={{
          background: "radial-gradient(circle, #58A6FF 0%, #E94560 100%)",
        }}
      />

      <motion.div
        initial={{ opacity: 0, y: 8 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.3, ease: [0.16, 1, 0.3, 1] }}
        className="container-shustho relative flex flex-col items-center py-16 text-center sm:py-24"
      >
        <span className="eyebrow mb-4">{t("eyebrow")}</span>
        <h1 className="max-w-3xl text-h1 sm:text-display text-text-primary-dark">
          {t("headline")}
        </h1>
        <p className="mt-6 max-w-xl text-body text-text-secondary-dark">
          {t("sub")}
        </p>

        <div className="mt-8 flex w-full flex-col gap-3 sm:w-auto sm:flex-row">
          <a href="#pricing" className="btn-primary">
            {t("cta1")}
          </a>
          <a href="#dashboard-preview" className="btn-secondary">
            {t("cta2")}
          </a>
        </div>

        <a
          href="#features"
          aria-label="Scroll to features"
          className="mt-16 motion-safe:animate-bounce text-text-tertiary-dark"
        >
          <ChevronDown size={24} strokeWidth={1.8} />
        </a>
      </motion.div>
    </section>
  );
}
