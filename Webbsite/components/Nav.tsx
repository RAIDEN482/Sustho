"use client";

import { useState } from "react";
import { Menu, X, Heart } from "lucide-react";

const links = [
  { label: "Features", href: "#features" },
  { label: "How it works", href: "#how-it-works" },
  { label: "Doctors", href: "#doctors" },
  { label: "FAQ", href: "#faq" },
];

export default function Nav() {
  const [open, setOpen] = useState(false);

  return (
    <header className="sticky top-0 z-50 border-b border-border-dark bg-bg-dark/90 backdrop-blur">
      <div className="container-shustho flex h-16 items-center justify-between">
        <a href="#" className="flex items-center gap-2">
          <span className="flex h-8 w-8 items-center justify-center rounded-md bg-primary">
            <Heart size={18} strokeWidth={1.8} className="text-white" />
          </span>
          <span className="text-h4 text-text-primary-dark">Shustho</span>
        </a>

        <nav className="hidden items-center gap-8 md:flex">
          {links.map((l) => (
            <a
              key={l.href}
              href={l.href}
              className="text-body-sm text-text-secondary-dark transition-colors duration-normal hover:text-text-primary-dark"
            >
              {l.label}
            </a>
          ))}
        </nav>

        <div className="hidden items-center gap-3 md:flex">
          <button className="text-body-sm text-text-secondary-dark">
            বাংলা / EN
          </button>
          <a href="#pricing" className="btn-primary">
            Download app
          </a>
        </div>

        <button
          className="md:hidden text-text-primary-dark"
          aria-label="Toggle menu"
          onClick={() => setOpen(!open)}
        >
          {open ? <X size={24} strokeWidth={1.8} /> : <Menu size={24} strokeWidth={1.8} />}
        </button>
      </div>

      {open && (
        <div className="border-t border-border-dark bg-bg-dark md:hidden">
          <div className="container-shustho flex flex-col gap-4 py-4">
            {links.map((l) => (
              <a key={l.href} href={l.href} className="text-body text-text-secondary-dark">
                {l.label}
              </a>
            ))}
            <a href="#pricing" className="btn-primary w-full">
              Download app
            </a>
          </div>
        </div>
      )}
    </header>
  );
}
