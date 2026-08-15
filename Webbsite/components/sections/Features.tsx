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

const features = [
  {
    icon: Calendar,
    title: "Period tracking",
    desc: "Log your period with one tap. Track cycle length, duration, and regularity.",
  },
  {
    icon: Droplets,
    title: "Flow measurement",
    desc: "Record flow intensity from light to heavy. Track products used and symptoms.",
  },
  {
    icon: BrainCircuit,
    title: "AI predictions",
    desc: "Smart predictions for your next period. Adapts to irregular cycles and PCOS.",
  },
  {
    icon: Apple,
    title: "Nutrition hub",
    desc: "Phase-based meal suggestions. Iron-rich foods, PCOS-friendly recipes, water tracking.",
  },
  {
    icon: Activity,
    title: "Pain tracker",
    desc: "Log pain levels 1–10, location, and relief methods. Identify patterns over time.",
  },
  {
    icon: Smile,
    title: "Mood & mind",
    desc: "Track daily mood, energy, and sleep. Understand emotional patterns with your cycle.",
  },
  {
    icon: AlertTriangle,
    title: "Health alerts",
    desc: "Red flag detection for serious symptoms. Guidance on when to see a doctor.",
  },
  {
    icon: Users,
    title: "Guardian care",
    desc: "Share selected health updates with trusted family. Full privacy control.",
  },
  {
    icon: Microscope,
    title: "PCOS support",
    desc: "Dedicated tracking for PCOS, endometriosis, PMDD, and more conditions.",
  },
];

export default function Features() {
  return (
    <section id="features" className="bg-bg-dark py-16 sm:py-24">
      <div className="container-shustho">
        <div className="max-w-xl">
          <span className="eyebrow">What's inside</span>
          <h2 className="section-title mt-3">Everything you need</h2>
          <p lang="bn" className="mt-2 text-h4 text-text-secondary-dark">
            আপনার যা যা প্রয়োজন সবকিছু
          </p>
        </div>

        <div className="mt-10 grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-3">
          {features.map(({ icon: Icon, title, desc }) => (
            <div key={title} className="card card-interactive group border-l-[3px] hover:border-l-primary">
              <span className="mb-4 flex h-12 w-12 items-center justify-center rounded-md bg-primary-50/10 text-primary">
                <Icon size={24} strokeWidth={1.8} />
              </span>
              <h3 className="text-h3 text-text-primary-dark">{title}</h3>
              <p className="mt-2 line-clamp-2 text-body-sm text-text-secondary-dark">
                {desc}
              </p>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
}
