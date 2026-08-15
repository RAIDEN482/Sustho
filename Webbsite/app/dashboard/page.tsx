"use client";

import { Bell, Settings, Droplets, Activity, Smile, Apple } from "lucide-react";

const quickActions = [
  { icon: Droplets, label: "Log flow" },
  { icon: Activity, label: "Log pain" },
  { icon: Smile, label: "Log mood" },
  { icon: Apple, label: "Log nutrition" },
];

export default function DashboardPage() {
  return (
    <div className="min-h-screen bg-bg-dark pb-24">
      <header className="flex items-center justify-between border-b border-border-dark px-4 py-4 sm:px-8">
        <div>
          <p className="text-caption text-text-tertiary-dark">Good morning</p>
          <p className="text-h3 text-text-primary-dark">Fatima</p>
        </div>
        <div className="flex items-center gap-4">
          <button aria-label="Notifications" className="relative text-text-secondary-dark">
            <Bell size={22} strokeWidth={1.8} />
            <span className="absolute -right-0.5 -top-0.5 h-2 w-2 rounded-full bg-danger" />
          </button>
          <button aria-label="Settings" className="text-text-secondary-dark">
            <Settings size={22} strokeWidth={1.8} />
          </button>
        </div>
      </header>

      <main className="mx-auto max-w-2xl px-4 py-6 sm:px-8">
        {/* Cycle status card */}
        <div className="rounded-lg border-[1.5px] border-primary bg-bg-dark-elevated p-5">
          <p className="eyebrow text-primary">Cycle status</p>
          <p className="mt-2 text-h2 tabular-nums text-text-primary-dark">Day 3 of period</p>
          <div className="mt-3 flex gap-4 text-body-sm text-text-secondary-dark">
            <span>Medium flow</span>
            <span>·</span>
            <span>Mild cramps</span>
          </div>
          <button className="btn-secondary mt-4">End period</button>
        </div>

        {/* Quick actions */}
        <div className="mt-4 grid grid-cols-4 gap-2">
          {quickActions.map(({ icon: Icon, label }) => (
            <button
              key={label}
              className="flex flex-col items-center gap-2 rounded-md border border-border-dark bg-bg-dark-muted px-2 py-4 text-center transition-colors duration-normal hover:border-primary"
            >
              <Icon size={22} strokeWidth={1.8} className="text-primary" />
              <span className="text-caption text-text-secondary-dark">{label}</span>
            </button>
          ))}
        </div>

        {/* Prediction card */}
        <div className="mt-4 rounded-lg border-[1.5px] border-secondary bg-bg-dark-elevated p-5">
          <p className="eyebrow text-secondary">Next prediction</p>
          <p className="mt-2 text-h2 tabular-nums text-text-primary-dark">Aug 28</p>
          <div className="mt-3 flex gap-4 text-body-sm text-text-secondary-dark">
            <span>85% confidence</span>
            <span>·</span>
            <span>in 13 days</span>
          </div>
        </div>

        {/* Alert banner */}
        <div className="mt-4 flex items-start gap-3 rounded-md border-l-[3px] border-warning bg-warning-50/10 px-4 py-3">
          <p className="text-body-sm text-warning">
            Your logged pain has trended up over the last 3 days. Consider noting this for your next doctor visit.
          </p>
        </div>

        {/* Today's summary */}
        <div className="card mt-4">
          <h3 className="text-h4 text-text-primary-dark">Today's summary</h3>
          <div className="mt-4 grid grid-cols-2 gap-4 sm:grid-cols-4">
            <div>
              <p className="text-caption text-text-tertiary-dark">Mood</p>
              <p className="mt-1 text-body-sm text-text-primary-dark">🙂 Okay</p>
            </div>
            <div>
              <p className="text-caption text-text-tertiary-dark">Water</p>
              <p className="mt-1 text-body-sm tabular-nums text-text-primary-dark">5/8 glasses</p>
            </div>
            <div>
              <p className="text-caption text-text-tertiary-dark">Pain</p>
              <p className="mt-1 text-body-sm tabular-nums text-text-primary-dark">4/10</p>
            </div>
            <div>
              <p className="text-caption text-text-tertiary-dark">Meals</p>
              <p className="mt-1 text-body-sm tabular-nums text-text-primary-dark">2 logged</p>
            </div>
          </div>
        </div>
      </main>

      {/* Bottom nav — mobile */}
      <nav className="fixed bottom-0 left-0 right-0 flex justify-around border-t border-border-dark bg-bg-dark-elevated py-3">
        {["Home", "Calendar", "Log", "Insights", "Settings"].map((t) => (
          <span key={t} className="text-caption text-text-tertiary-dark">
            {t}
          </span>
        ))}
      </nav>
    </div>
  );
}
