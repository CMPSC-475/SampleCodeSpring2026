import FlightTable from "./components/FlightsTable";

export default function Home() {
  return (
    <main className="mx-auto w-full max-w-5xl px-4 py-8 sm:px-6 lg:px-8">
      <h1 className="mb-6 text-center text-2xl font-bold text-gray-100 sm:text-3xl">
          Available Flights
      </h1>
      <section className="rounded-xl border border-slate-800 bg-slate-900/70 p-4 shadow-sm sm:p-6">
        <FlightTable />
      </section>
    </main>
  );
}
