import Nav from "@/components/Nav";
import Footer from "@/components/Footer";
import Hero from "@/components/sections/Hero";
import Features from "@/components/sections/Features";
import HowItWorks from "@/components/sections/HowItWorks";
import DashboardPreview from "@/components/sections/DashboardPreview";
import Conditions from "@/components/sections/Conditions";
import Guardian from "@/components/sections/Guardian";
import Testimonials from "@/components/sections/Testimonials";
import DoctorNetwork from "@/components/sections/DoctorNetwork";
import Pricing from "@/components/sections/Pricing";
import FAQ from "@/components/sections/FAQ";

export default function Home() {
  return (
    <>
      <Nav />
      <main>
        <Hero />
        <Features />
        <HowItWorks />
        <DashboardPreview />
        <Conditions />
        <Guardian />
        <Testimonials />
        <DoctorNetwork />
        <Pricing />
        <FAQ />
      </main>
      <Footer />
    </>
  );
}
