const steps = [
  {
    n: 1,
    title: "Log your period",
    desc: "Tap to record your period start and end dates. Add flow intensity and symptoms.",
  },
  {
    n: 2,
    title: "Track daily",
    desc: "Log pain, mood, nutrition, and any health changes each day.",
  },
  {
    n: 3,
    title: "Get insights",
    desc: "View trends, predictions, and personalized health tips based on your data.",
  },
  {
    n: 4,
    title: "Share & care",
    desc: "Optionally share updates with a guardian. Export reports for your doctor.",
  },
];

export default function HowItWorks() {
  return (
    <section id="how-it-works" className="bg-bg-dark-elevated py-16 sm:py-24">
      <div className="container-shustho">
        <div className="max-w-xl">
          <span className="eyebrow">Four simple steps</span>
          <h2 className="section-title mt-3">How Shustho works</h2>
          <p lang="bn" className="mt-2 text-h4 text-text-secondary-dark">
            শুস্থ যেভাবে কাজ করে
          </p>
        </div>

        <ol className="relative mt-12 grid grid-cols-1 gap-8 sm:grid-cols-2 lg:grid-cols-4">
          {steps.map((s, i) => (
            <li key={s.n} className="relative flex flex-col items-start">
              {i < steps.length - 1 && (
                <span
                  aria-hidden
                  className="absolute left-6 top-6 hidden h-[2px] w-full bg-primary lg:block"
                />
              )}
              <span className="relative z-10 flex h-12 w-12 items-center justify-center rounded-full bg-primary text-h4 text-white">
                {s.n}
              </span>
              <h3 className="mt-4 text-h3 text-text-primary-dark">{s.title}</h3>
              <p className="mt-2 text-body-sm text-text-secondary-dark">{s.desc}</p>
            </li>
          ))}
        </ol>
      </div>
    </section>
  );
}
