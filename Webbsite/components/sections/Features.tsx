"use client";

import {
  Calendar,
  Droplets,
  BrainCircuit,
  Apple,
  Activity,
  Smile,
  AlertTriangle,
  Users,
  Microscope,
} from "lucide-react";
import { useTranslations } from "next-intl";
import { motion } from "framer-motion";

const icons = [Calendar, Droplets, BrainCircuit, Apple, Activity, Smile, AlertTriangle, Users, Microscope];

export default function Features() {
  const t = useTranslations("features");
  const items = t.raw("items") as { title: string; desc: string }[];

  return (
    <section id="features" className="bg-bg-dark py-16 sm:py-24">
      <div className="container-shustho">
        <div className="max-w-xl">
          <span className="eyebrow">{t("eyebrow")}</span>
          <h2 className="section-title mt-3">{t("title")}</h2>
        </div>

        <div className="mt-10 grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-3">
          {items.map((item, i) => {
            const Icon = icons[i];
            return (
              <motion.div
                key={item.title}
                initial={{ opacity: 0, y: 12 }}
                whileInView={{ opacity: 1, y: 0 }}
                viewport={{ once: true, margin: "-40px" }}
                transition={{ duration: 0.3, delay: (i % 3) * 0.05, ease: [0.16, 1, 0.3, 1] }}
                className="card card-interactive group border-l-[3px] hover:border-l-primary"
              >
                <span className="mb-4 flex h-12 w-12 items-center justify-center rounded-md bg-primary-50/10 text-primary">
                  <Icon size={24} strokeWidth={1.8} />
                </span>
                <h3 className="text-h3 text-text-primary-dark">{item.title}</h3>
                <p className="mt-2 line-clamp-2 text-body-sm text-text-secondary-dark">
                  {item.desc}
                </p>
              </motion.div>
            );
          })}
        </div>
      </div>
    </section>
  );
}
