"use client";

import { useState } from "react";
import { ChevronDown } from "lucide-react";

const faqs = [
  {
    q: "Is my data really private?",
    a: "Yes. By default all your health data is stored locally on your device using encrypted local storage. Nothing is sent to a server unless you explicitly enable cloud backup.",
  },
  {
    q: "Can I use Shustho without internet?",
    a: "Yes. Period logging, symptom tracking, charts, insights, and report generation all work fully offline.",
  },
  {
    q: "How accurate are the period predictions?",
    a: "Predictions improve as you log more cycles and adapt automatically to irregular patterns, including PCOS-related irregularity.",
  },
  {
    q: "Can I track PCOS symptoms?",
    a: "Yes. Shustho has dedicated tracking for PCOS alongside endometriosis, PMDD, fibroids, and thyroid conditions.",
  },
  {
    q: "How does the guardian feature work?",
    a: "You choose a trusted person and exactly what they can see — cycle status, severe pain alerts, mood summaries, or more. You can revoke access at any time.",
  },
  {
    q: "Is Bangla language fully supported?",
    a: "Yes. Every screen, alert, health tip, and report is available in both Bangla and English.",
  },
  {
    q: "Can I export data for my doctor?",
    a: "Yes. Generate a formatted PDF or CSV report for any date range from the Health tab.",
  },
  {
    q: "Will there be ads or paid features?",
    a: "No. Shustho is free forever with no ads and no paid tiers.",
  },
];

export default function FAQ() {
  const [openIndex, setOpenIndex] = useState<number | null>(0);

  return (
    <section id="faq" className="bg-bg-dark py-16 sm:py-24">
      <div className="container-shustho max-w-2xl">
        <span className="eyebrow">Questions</span>
        <h2 className="section-title mt-3">Frequently asked questions</h2>
        <p lang="bn" className="mt-2 text-h4 text-text-secondary-dark">
          সচরাচর জিজ্ঞাসিত প্রশ্ন
        </p>

        <div className="mt-8 divide-y divide-border-dark border-y border-border-dark">
          {faqs.map((f, i) => {
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
