import { Heart, Mail, MessageCircle, Facebook } from "lucide-react";

export default function Footer() {
  return (
    <footer className="bg-bg-dark border-t border-border-dark">
      <div className="container-shustho grid grid-cols-1 gap-10 py-16 sm:grid-cols-2 lg:grid-cols-4">
        <div>
          <div className="flex items-center gap-2">
            <span className="flex h-8 w-8 items-center justify-center rounded-md bg-primary">
              <Heart size={18} strokeWidth={1.8} className="text-white" />
            </span>
            <span className="text-h4 text-text-primary-dark">Shustho</span>
          </div>
          <p className="mt-3 max-w-[220px] text-body-sm text-text-secondary-dark">
            Free, private, offline-first health tracking for Bangladesh.
          </p>
        </div>

        <div>
          <h4 className="text-h4 text-text-primary-dark">Quick links</h4>
          <ul className="mt-4 space-y-2 text-body-sm text-text-secondary-dark">
            <li><a href="#features">Features</a></li>
            <li><a href="#how-it-works">How it works</a></li>
            <li><a href="#doctors">Doctor network</a></li>
            <li><a href="#faq">FAQ</a></li>
          </ul>
        </div>

        <div>
          <h4 className="text-h4 text-text-primary-dark">Legal</h4>
          <ul className="mt-4 space-y-2 text-body-sm text-text-secondary-dark">
            <li><a href="#">Privacy policy</a></li>
            <li><a href="#">Terms of service</a></li>
            <li><a href="#">Data policy</a></li>
          </ul>
        </div>

        <div>
          <h4 className="text-h4 text-text-primary-dark">Connect</h4>
          <div className="mt-4 flex gap-4 text-text-secondary-dark">
            <a href="mailto:hello@shustho.app" aria-label="Email"><Mail size={20} strokeWidth={1.8} /></a>
            <a href="#" aria-label="WhatsApp"><MessageCircle size={20} strokeWidth={1.8} /></a>
            <a href="#" aria-label="Facebook"><Facebook size={20} strokeWidth={1.8} /></a>
          </div>
        </div>
      </div>

      <div className="border-t border-border-dark">
        <div className="container-shustho flex flex-col items-center justify-between gap-3 py-6 sm:flex-row">
          <p className="text-caption text-text-tertiary-dark">© {new Date().getFullYear()} Shustho. All rights reserved.</p>
          <button className="text-caption text-text-tertiary-dark">বাংলা / English</button>
        </div>
      </div>
    </footer>
  );
}
