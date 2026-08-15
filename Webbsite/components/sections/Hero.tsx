import { ChevronDown } from "lucide-react";

export default function Hero() {
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

      <div className="container-shustho relative flex flex-col items-center py-16 text-center sm:py-24">
        <span className="eyebrow mb-4">Built for Bangladesh</span>
        <h1 className="max-w-3xl text-h1 sm:text-display text-text-primary-dark">
          Track your cycle. Own your health.
        </h1>
        <p lang="bn" className="mt-3 max-w-2xl text-h3 text-text-secondary-dark">
          আপনার সাইকেল ট্র্যাক করুন। আপনার স্বাস্থ্যের দায়িত্ব নিন।
        </p>
        <p className="mt-6 max-w-xl text-body text-text-secondary-dark">
          Shustho is a free, offline-first period and reproductive health tracker
          built for Bangladesh. Your data stays on your device — private,
          secure, and yours alone.
        </p>

        <div className="mt-8 flex w-full flex-col gap-3 sm:w-auto sm:flex-row">
          <a href="#pricing" className="btn-primary">
            Download app
          </a>
          <a href="#dashboard-preview" className="btn-secondary">
            Use web version
          </a>
        </div>

        <a
          href="#features"
          aria-label="Scroll to features"
          className="mt-16 animate-bounce text-text-tertiary-dark"
        >
          <ChevronDown size={24} strokeWidth={1.8} />
        </a>
      </div>
    </section>
  );
}
