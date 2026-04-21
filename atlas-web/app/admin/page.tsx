"use client";

import { useEffect, useMemo, useState } from "react";
import FlightTable from "../components/FlightsTable";
import AddFlightsForm from "../components/AddFlightForm";
import { useFlights } from "../context/useFlights";
import { getFlightKey } from "../models/flight";

export default function Home() {
  const { flights, setFlights } = useFlights();
  const [selectedFlightIds, setSelectedFlightIds] = useState<string[]>([]);

  const flightIds = useMemo(
    () => flights.map((flight, index) => getFlightKey(flight, index)),
    [flights]
  );

  useEffect(() => {
    setSelectedFlightIds((prev) => prev.filter((flightId) => flightIds.includes(flightId)));
  }, [flightIds]);

  const handleToggleFlight = (flightId: string) => {
    setSelectedFlightIds((prev) =>
      prev.includes(flightId)
        ? prev.filter((id) => id !== flightId)
        : [...prev, flightId]
    );
  };

  const handleToggleAllFlights = () => {
    setSelectedFlightIds((prev) =>
      prev.length === flights.length ? [] : flightIds
    );
  };

  const handleDeleteSelected = () => {
    if (selectedFlightIds.length === 0) return;

    const selectedFlightSet = new Set(selectedFlightIds);
    setFlights((prev) =>
      prev.filter((flight, index) => !selectedFlightSet.has(getFlightKey(flight, index)))
    );
    setSelectedFlightIds([]);
  };

  return (
    <main className="mx-auto w-full max-w-5xl px-4 py-8 sm:px-6 lg:px-8">
      <h1 className="mb-6 text-center text-2xl font-bold text-gray-100 sm:text-3xl">
          Available Flights
      </h1>
      <section className="rounded-xl border border-slate-800 bg-slate-900/70 p-4 shadow-sm sm:p-6">
        <div className="mb-4 flex justify-end">
          <button
            type="button"
            onClick={handleDeleteSelected}
            disabled={selectedFlightIds.length === 0}
            className="rounded-md bg-red-600 px-4 py-2 text-white transition-colors hover:bg-red-500 focus:outline-none focus:ring-2 focus:ring-red-400 disabled:cursor-not-allowed disabled:bg-slate-600"
          >
            Delete Selected
          </button>
        </div>
        <FlightTable
          showSelection
          selectedFlightIds={selectedFlightIds}
          onToggleFlight={handleToggleFlight}
          onToggleAllFlights={handleToggleAllFlights}
        />
      </section>
      <section className="mt-6 rounded-xl border border-slate-800 bg-slate-900/70 p-4 shadow-sm sm:p-6">
        <AddFlightsForm />
      </section>
    </main>
  );
}
