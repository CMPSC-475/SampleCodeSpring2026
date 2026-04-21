import type { Metadata } from "next";
import { Geist, Geist_Mono } from "next/font/google";
import "./globals.css";
import { FlightsProvider } from "./context/useFlights";

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html>
      <body className="min-h-full flex flex-col bg-slate-950 text-gray-100 antialiased">
        <FlightsProvider>
          {children}
        </FlightsProvider>
      </body>
    </html>
  );
}
