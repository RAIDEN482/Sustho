import { Star } from "lucide-react";

const testimonials = [
  {
    quote:
      "Shustho helped me identify my PCOS symptoms early. The doctor report feature saved me so much time.",
    name: "Fatima",
    meta: "24, Dhaka",
  },
  {
    quote:
      "My husband gets alerts when my pain is severe. He knows when to help without me asking.",
    name: "Ayesha",
    meta: "28, Chittagong",
  },
  {
    quote:
      "Finally a period tracker that works offline. I don't worry about my data being sold.",
    name: "Nusrat",
    meta: "19, Sylhet",
  },
];

export default function Testimonials() {
  return (
    <section className="bg-bg-dark-elevated py-16 sm:py-24">
      <div className="container-shustho">
        <div className="max-w-xl">
          <span className="eyebrow">Real stories</span>
          <h2 className="section-title mt-3">What users say</h2>
          <p lang="bn" className="mt-2 text-h4 text-text-secondary-dark">
            ব্যবহারকারীরা যা বলেন
          </p>
        </div>

        <div className="mt-10 grid grid-cols-1 gap-4 sm:grid-cols-3">
          {testimonials.map((t) => (
            <div key={t.name} className="rounded-lg border border-border-dark border-l-[3px] border-l-primary bg-bg-dark p-6">
              <div className="flex gap-0.5 text-warning">
                {Array.from({ length: 5 }).map((_, i) => (
                  <Star key={i} size={14} fill="currentColor" strokeWidth={0} />
                ))}
              </div>
              <p className="mt-4 text-body italic text-text-primary-dark">"{t.quote}"</p>
              <div className="mt-5 flex items-center gap-3">
                <span className="flex h-10 w-10 items-center justify-center rounded-full bg-primary-50/10 text-body-sm text-primary">
                  {t.name[0]}
                </span>
                <div>
                  <p className="text-body-sm text-text-primary-dark">{t.name}</p>
                  <p className="text-caption text-text-tertiary-dark">{t.meta}</p>
                </div>
              </div>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
}
