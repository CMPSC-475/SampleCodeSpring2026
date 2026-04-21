"use client";

import * as React from "react";
import { useState } from "react";
import { useFlights } from "../context/useFlights";
import { emptyFlight } from "../models/flight";

export default function AddFlightsForm() {
  const { setFlights } = useFlights();

  const [flight, setInputFlight] = useState(emptyFlight());

  const handleSubmit = (e: React.SubmitEvent<HTMLFormElement>) => {
    e.preventDefault();
    if (!flight.flightNumber.trim()) return;

    setFlights((prev) => [...prev, flight]);
    setInputFlight(emptyFlight());
  };

  return (
    <form onSubmit={handleSubmit} className="flex flex-col gap-3">
      <h2 className="text-lg font-semibold text-gray-100">Add a flight</h2>
      <input
        type="text"
        placeholder="Flight Number"
        value={flight.flightNumber}
        onChange={(e: React.ChangeEvent<HTMLInputElement>) =>
          setInputFlight((f) => ({ ...f, flightNumber: e.target.value }))
        }
        className="w-full rounded-md border border-slate-700 bg-slate-950 px-3 py-2 text-sm text-gray-100 placeholder:text-gray-400 focus:border-slate-500 focus:outline-none focus:ring-2 focus:ring-slate-600"
      />
      <input
        type="text"
        placeholder="Departure Airport"
        value={flight.departureAirport}
        onChange={(e: React.ChangeEvent<HTMLInputElement>) =>
          setInputFlight((f) => ({ ...f, departureAirport: e.target.value }))
        }
        className="w-full rounded-md border border-slate-700 bg-slate-950 px-3 py-2 text-sm text-gray-100 placeholder:text-gray-400 focus:border-slate-500 focus:outline-none focus:ring-2 focus:ring-slate-600"
      />
      <input
        type="text"
        placeholder="Arrival Airport"
        value={flight.arrivalAirport}
        onChange={(e: React.ChangeEvent<HTMLInputElement>) =>
          setInputFlight((f) => ({ ...f, arrivalAirport: e.target.value }))
        }
        className="w-full rounded-md border border-slate-700 bg-slate-950 px-3 py-2 text-sm text-gray-100 placeholder:text-gray-400 focus:border-slate-500 focus:outline-none focus:ring-2 focus:ring-slate-600"
      />
      <input
        type="number"
        min={0}
        step={1}
        placeholder="Price"
        value={flight.price === 0 ? "" : flight.price}
        onChange={(e: React.ChangeEvent<HTMLInputElement>) => {
          const v = e.target.value;
          setInputFlight((f) => ({
            ...f,
            price: v === "" ? 0 : Number(v),
          }));
        }}
        className="w-full rounded-md border border-slate-700 bg-slate-950 px-3 py-2 text-sm text-gray-100 placeholder:text-gray-400 focus:border-slate-500 focus:outline-none focus:ring-2 focus:ring-slate-600"
      />
      <button
        type="submit"
        className="mt-1 rounded-md bg-indigo-500 px-4 py-2 font-medium text-white transition-colors hover:bg-indigo-400 focus:outline-none focus:ring-2 focus:ring-indigo-300"
      >
        Add Flight
      </button>
    </form>
  );
}
