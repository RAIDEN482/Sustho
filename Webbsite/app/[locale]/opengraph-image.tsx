import { ImageResponse } from "next/og";

export const runtime = "edge";
export const alt = "Shustho — Free period & health tracker for Bangladesh";
export const size = { width: 1200, height: 630 };
export const contentType = "image/png";

export default async function OgImage() {
  return new ImageResponse(
    (
      <div
        style={{
          width: "100%",
          height: "100%",
          display: "flex",
          flexDirection: "column",
          justifyContent: "center",
          alignItems: "flex-start",
          padding: "80px",
          backgroundColor: "#0D1117",
          backgroundImage:
            "radial-gradient(circle at 85% 20%, rgba(233,69,96,0.35), transparent 45%), radial-gradient(circle at 10% 90%, rgba(88,166,255,0.25), transparent 45%)",
        }}
      >
        <div style={{ display: "flex", alignItems: "center", gap: 16 }}>
          <div
            style={{
              width: 56,
              height: 56,
              borderRadius: 12,
              background: "#E94560",
              display: "flex",
              alignItems: "center",
              justifyContent: "center",
              fontSize: 32,
              color: "white",
            }}
          >
            ♥
          </div>
          <div style={{ fontSize: 40, color: "#C9D1D9", fontWeight: 500 }}>Shustho</div>
        </div>
        <div
          style={{
            marginTop: 40,
            fontSize: 56,
            fontWeight: 500,
            color: "#C9D1D9",
            lineHeight: 1.15,
            maxWidth: 900,
          }}
        >
          Track your cycle. Own your health.
        </div>
        <div style={{ marginTop: 24, fontSize: 24, color: "#8B949E", maxWidth: 800 }}>
          Free, offline-first period &amp; reproductive health tracker for Bangladesh
        </div>
      </div>
    ),
    { ...size }
  );
}
