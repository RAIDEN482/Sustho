"use client";

import { BarChart, Bar, Cell, LineChart, Line, ResponsiveContainer, XAxis, Tooltip } from "recharts";
import { useTranslations } from "next-intl";

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
  const t = useTranslations("dashboardPreview");

  return (
    <section id="dashboard-preview" className="bg-bg-dark py-16 sm:py-24">
      <div className="container-shustho">
        <div className="max-w-xl">
          <span className="eyebrow">{t("eyebrow")}</span>
          <h2 className="section-title mt-3">{t("title")}</h2>
        </div>

        <div className="mt-10 rounded-2xl border border-border-dark bg-bg-dark-elevated p-4 sm:p-6">
          <div className="grid grid-cols-1 gap-4 lg:grid-cols-2">
            <div className="rounded-lg border-[1.5px] border-primary bg-bg-dark-muted p-5">
              <span className="eyebrow text-primary">{t("cycleStatus")}</span>
              <p className="mt-2 text-h2 text-text-primary-dark tabular-nums">{t("cycleStatusValue")}</p>
              <div className="mt-3 flex gap-4 text-body-sm text-text-secondary-dark">
                <span>{t("mediumFlow")}</span>
                <span>·</span>
                <span>{t("mildCramps")}</span>
              </div>
            </div>

            <div className="rounded-lg border-[1.5px] border-secondary bg-bg-dark-muted p-5">
              <span className="eyebrow text-secondary">{t("nextPrediction")}</span>
              <p className="mt-2 text-h2 text-text-primary-dark tabular-nums">{t("nextPredictionValue")}</p>
              <div className="mt-3 text-body-sm text-text-secondary-dark">{t("confidence")}</div>
            </div>

            <div className="card">
              <h3 className="text-h4 text-text-primary-dark">{t("painChart")}</h3>
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
              <h3 className="text-h4 text-text-primary-dark">{t("moodChart")}</h3>
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
            <a href="#pricing" className="btn-primary">
              {t("cta")}
            </a>
          </div>
        </div>
      </div>
    </section>
  );
}
