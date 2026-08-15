"use client";

import { useState } from "react";

const conditions = [
  {
    name: "PCOS",
    desc: "Polycystic ovary syndrome affects hormone levels and ovulation. Shustho tracks the symptom patterns that matter for diagnosis and management.",
    tracks: ["Cycle irregularity", "Weight trends", "Acne severity", "Hair growth patterns"],
  },
  {
    name: "Endometriosis",
    desc: "Tissue similar to the uterine lining grows outside the uterus, often causing severe pain. Detailed pain logs help doctors spot patterns faster.",
    tracks: ["Pain location & intensity", "Pain relief effectiveness", "Cycle correlation", "Fatigue levels"],
  },
  {
    name: "PMDD",
    desc: "A severe form of premenstrual syndrome affecting mood. Daily mood tracking reveals the cyclical pattern that distinguishes PMDD.",
    tracks: ["Daily mood score", "Energy levels", "Sleep quality", "Symptom timing vs cycle"],
  },
  {
    name: "Fibroids",
    desc: "Non-cancerous growths in the uterus that can affect flow and pain. Flow tracking over time highlights changes worth discussing with a doctor.",
    tracks: ["Flow intensity", "Clot size", "Bleeding duration", "Pain during period"],
  },
  {
    name: "Thyroid",
    desc: "Thyroid conditions can disrupt cycle regularity. Long-term cycle-length trends make irregularities easy to spot.",
    tracks: ["Cycle length trend", "Energy & fatigue", "Weight changes", "Mood swings"],
  },
];

export default function Conditions() {
  const [active, setActive] = useState(0);
  const c = conditions[active];

  return (
    <section className="bg-bg-dark-elevated py-16 sm:py-24">
      <div className="container-shustho">
        <div className="max-w-xl">
          <span className="eyebrow text-success">Beyond period tracking</span>
          <h2 className="section-title mt-3">Conditions we support</h2>
          <p lang="bn" className="mt-2 text-h4 text-text-secondary-dark">
            পিরিয়ড ট্র্যাকিংয়ের বাইরেও
          </p>
        </div>

        <div className="mt-8 flex gap-2 overflow-x-auto pb-2">
          {conditions.map((item, i) => (
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
            {c.tracks.map((t) => (
              <li key={t} className="flex items-center gap-2 text-body-sm text-text-secondary-dark">
                <span className="h-1.5 w-1.5 rounded-full bg-success" />
                {t}
              </li>
            ))}
          </ul>
          <a href="#faq" className="mt-4 inline-block text-body-sm text-success">
            Learn more →
          </a>
        </div>
      </div>
    </section>
  );
}
