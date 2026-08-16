"use client";

import { useTranslations } from "next-intl";
import { motion } from "framer-motion";

export default function HowItWorks() {
  const t = useTranslations("howItWorks");
  const steps = t.raw("steps") as { title: string; desc: string }[];

  return (
    <section id="how-it-works" className="bg-bg-dark-elevated py-16 sm:py-24">
      <div className="container-shustho">
        <div className="max-w-xl">
          <span className="eyebrow">{t("eyebrow")}</span>
          <h2 className="section-title mt-3">{t("title")}</h2>
        </div>

        <ol className="relative mt-12 grid grid-cols-1 gap-8 sm:grid-cols-2 lg:grid-cols-4">
          {steps.map((s, i) => (
            <motion.li
              key={s.title}
              initial={{ opacity: 0, y: 12 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true, margin: "-40px" }}
              transition={{ duration: 0.3, delay: i * 0.08, ease: [0.16, 1, 0.3, 1] }}
              className="relative flex flex-col items-start"
            >
              {i < steps.length - 1 && (
                <span
                  aria-hidden
                  className="absolute left-6 top-6 hidden h-[2px] w-full bg-primary lg:block"
                />
              )}
              <span className="relative z-10 flex h-12 w-12 items-center justify-center rounded-full bg-primary text-h4 text-white">
                {i + 1}
              </span>
              <h3 className="mt-4 text-h3 text-text-primary-dark">{s.title}</h3>
              <p className="mt-2 text-body-sm text-text-secondary-dark">{s.desc}</p>
            </motion.li>
          ))}
        </ol>
      </div>
    </section>
  );
}
