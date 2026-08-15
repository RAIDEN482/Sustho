import { CheckCircle2 } from "lucide-react";

const perks = [
  "Unlimited period tracking",
  "AI-powered predictions",
  "Offline mode",
  "Pain & mood tracking",
  "Nutrition hub",
  "Guardian access",
  "PCOS & condition tracking",
  "Doctor report export",
  "All languages",
  "No ads, ever",
];

export default function Pricing() {
  return (
    <section id="pricing" className="bg-bg-dark-elevated py-16 sm:py-24">
      <div className="container-shustho flex flex-col items-center text-center">
        <span className="eyebrow">No hidden costs</span>
        <h2 className="section-title mt-3">Completely free. Forever.</h2>
        <p lang="bn" className="mt-2 text-h4 text-text-secondary-dark">
          সম্পূর্ণ বিনামূল্যে, চিরকাল
        </p>

        <div className="mt-10 w-full max-w-md rounded-2xl border border-border-dark bg-bg-dark p-8">
          <CheckCircle2 size={64} strokeWidth={1.8} className="mx-auto text-success" />
          <p className="mt-4 text-display text-text-primary-dark">$0 / forever</p>

          <ul className="mt-6 space-y-2 text-left">
            {perks.map((p) => (
              <li key={p} className="flex items-center gap-2 text-body-sm text-text-secondary-dark">
                <CheckCircle2 size={16} strokeWidth={1.8} className="shrink-0 text-success" />
                {p}
              </li>
            ))}
          </ul>

          <a href="#" className="btn-primary mt-8 w-full">
            Download now
          </a>
          <p className="mt-3 text-caption text-text-tertiary-dark">No credit card required</p>
        </div>
      </div>
    </section>
  );
}
