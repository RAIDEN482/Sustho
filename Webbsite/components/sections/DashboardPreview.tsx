"use client";

import { BarChart, Bar, Cell, LineChart, Line, ResponsiveContainer, XAxis, Tooltip } from "recharts";

const painData = [
  { day: "Mon", pain: 2 },
  { day: "Tue", pain: 4 },
  { day: "Wed", pain: 6 },
  { day: "Thu", pain: 5 },
  { day: "Fri", pain: 3 },
  { day: "Sat", pain: 2 },
  { day: "Sun", pain: 1 },
];

const moodData = Array.from({ length: 14 }, (_, i) => ({
  day: i + 1,
  mood: Math.round(3 + 2 * Math.sin(i / 2)),
}));

export default function DashboardPreview() {
  return (
    <section id="dashboard-preview" className="bg-bg-dark py-16 sm:py-24">
      <div className="container-shustho">
        <div className="max-w-xl">
          <span className="eyebrow">Live preview</span>
          <h2 className="section-title mt-3">Your health dashboard</h2>
          <p lang="bn" className="mt-2 text-h4 text-text-secondary-dark">
            আপনার স্বাস্থ্য ড্যাশবোর্ড
          </p>
        </div>

        <div className="mt-10 rounded-2xl border border-border-dark bg-bg-dark-elevated p-4 sm:p-6">
          <div className="grid grid-cols-1 gap-4 lg:grid-cols-2">
            <div className="rounded-lg border-[1.5px] border-primary bg-bg-dark-muted p-5">
              <span className="eyebrow text-primary">Cycle status</span>
              <p className="mt-2 text-h2 text-text-primary-dark tabular-nums">Day 3 of period</p>
              <div className="mt-3 flex gap-4 text-body-sm text-text-secondary-dark">
                <span>Medium flow</span>
                <span>·</span>
                <span>Mild cramps</span>
              </div>
            </div>

            <div className="rounded-lg border-[1.5px] border-secondary bg-bg-dark-muted p-5">
              <span className="eyebrow text-secondary">Next prediction</span>
              <p className="mt-2 text-h2 text-text-primary-dark tabular-nums">Next period: Aug 28</p>
              <div className="mt-3 text-body-sm text-text-secondary-dark">85% confidence</div>
            </div>

            <div className="card">
              <h3 className="text-h4 text-text-primary-dark">Pain — last 7 days</h3>
              <div className="mt-4 h-40">
                <ResponsiveContainer width="100%" height="100%">
                  <BarChart data={painData}>
                    <XAxis
                      dataKey="day"
                      tick={{ fill: "#8B949E", fontSize: 12 }}
                      axisLine={{ stroke: "#30363D" }}
                      tickLine={false}
                    />
                    <Tooltip
                      contentStyle={{
                        background: "#161B22",
                        border: "1px solid #30363D",
                        borderRadius: 8,
                        fontSize: 12,
                      }}
                    />
                    <Bar dataKey="pain" radius={[4, 4, 0, 0]}>
                      {painData.map((d, i) => (
                        <Cell key={i} fill={d.pain >= 7 ? "#DA3633" : d.pain >= 4 ? "#D29922" : "#238636"} />
                      ))}
                    </Bar>
                  </BarChart>
                </ResponsiveContainer>
              </div>
            </div>

            <div className="card">
              <h3 className="text-h4 text-text-primary-dark">Mood — last 14 days</h3>
              <div className="mt-4 h-40">
                <ResponsiveContainer width="100%" height="100%">
                  <LineChart data={moodData}>
                    <XAxis dataKey="day" hide />
                    <Tooltip
                      contentStyle={{
                        background: "#161B22",
                        border: "1px solid #30363D",
                        borderRadius: 8,
                        fontSize: 12,
                      }}
                    />
                    <Line
                      type="monotone"
                      dataKey="mood"
                      stroke="#58A6FF"
                      strokeWidth={2}
                      dot={false}
                      animationDuration={800}
                    />
                  </LineChart>
                </ResponsiveContainer>
              </div>
            </div>
          </div>

          <div className="mt-6 flex justify-center">
            <a href="/dashboard" className="btn-primary">
              Try the full app
            </a>
          </div>
        </div>
      </div>
    </section>
  );
}
