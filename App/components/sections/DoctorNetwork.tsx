"use client";

import { useState } from "react";
import { Phone, Search } from "lucide-react";
import { useTranslations } from "next-intl";

const hospitals = [
  {
    name: "Square Hospital",
    city: "Dhaka",
    address: "18/F, Bir Uttam Qazi Nuruzzaman Sarak, West Panthapath",
    phone: "+880-2-8144466",
    specialties: ["Gynecology", "Fertility", "Endocrinology"],
  },
  {
    name: "Evercare Hospital",
    city: "Dhaka",
    address: "Plot 81, Block E, Bashundhara R/A",
    phone: "+880-10678-55555",
    specialties: ["Gynecology", "Endocrinology"],
  },
  {
    name: "Chittagong Medical Centre",
    city: "Chittagong",
    address: "O.R. Nizam Road, Chittagong",
    phone: "+880-31-2551661",
    specialties: ["Gynecology"],
  },
];

const cities = ["Dhaka", "Chittagong", "Sylhet", "Rajshahi", "Khulna", "Barisal", "Rangpur"];

export default function DoctorNetwork() {
  const t = useTranslations("doctors");
  const [city, setCity] = useState("All");
  const filtered = hospitals.filter((h) => city === "All" || h.city === city);

  return (
    <section id="doctors" className="bg-bg-dark py-16 sm:py-24">
      <div className="container-shustho">
        <div className="max-w-xl">
          <span className="eyebrow">{t("eyebrow")}</span>
          <h2 className="section-title mt-3">{t("title")}</h2>
        </div>

        <div className="mt-8 flex flex-col gap-3 sm:flex-row sm:items-center">
          <div className="flex flex-1 items-center gap-2 rounded-md border border-border-dark bg-bg-dark-muted px-4 py-3">
            <Search size={18} strokeWidth={1.8} className="text-text-tertiary-dark" />
            <input
              placeholder={t("searchPlaceholder")}
              className="w-full bg-transparent text-body-sm text-text-primary-dark placeholder:text-text-tertiary-dark outline-none"
            />
          </div>
          <select
            value={city}
            onChange={(e) => setCity(e.target.value)}
            className="rounded-md border border-border-dark bg-bg-dark-muted px-4 py-3 text-body-sm text-text-primary-dark outline-none"
          >
            <option value="All">{t("allCities")}</option>
            {cities.map((c) => (
              <option key={c} value={c}>
                {c}
              </option>
            ))}
          </select>
        </div>

        <div className="mt-6 grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-3">
          {filtered.map((h) => (
            <div key={h.name} className="card card-interactive">
              <h3 className="text-h4 text-text-primary-dark">{h.name}</h3>
              <p className="mt-1 text-caption text-text-tertiary-dark">{h.city}</p>
              <p className="mt-3 text-body-sm text-text-secondary-dark">{h.address}</p>
              <div className="mt-3 flex flex-wrap gap-2">
                {h.specialties.map((s) => (
                  <span key={s} className="rounded-sm bg-bg-dark-muted px-3 py-1 text-caption text-text-secondary-dark">
                    {s}
                  </span>
                ))}
              </div>
              <a
                href={`tel:${h.phone}`}
                className="mt-4 flex items-center justify-center gap-2 rounded-md border-[1.5px] border-primary py-2.5 text-button text-primary transition-colors duration-normal hover:bg-primary/[0.08]"
              >
                <Phone size={16} strokeWidth={1.8} />
                {t("call")}
              </a>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
}
