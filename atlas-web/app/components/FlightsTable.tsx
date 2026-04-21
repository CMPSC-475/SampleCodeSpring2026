"use client";

import { useFlights } from "../context/useFlights";
import { getFlightKey } from "../models/flight";

type FlightTableProps = {
  showSelection?: boolean;
  selectedFlightIds?: string[];
  onToggleFlight?: (flightId: string) => void;
  onToggleAllFlights?: () => void;
};

export default function FlightTable({
  showSelection = false,
  selectedFlightIds = [],
  onToggleFlight,
  onToggleAllFlights,
}: FlightTableProps) {
  const { flights } = useFlights();
  const allFlightsSelected =
    flights.length > 0 && selectedFlightIds.length === flights.length;

  return (
    <div className="overflow-hidden rounded-xl border border-slate-800">
      <table className="w-full text-sm text-gray-100">
          <thead className="bg-slate-950 text-left text-xs font-semibold uppercase tracking-wide text-gray-400">
            <tr className="border-b border-slate-800">
              {showSelection && (
                <th className="w-12 p-4">
                  <input
                    type="checkbox"
                    aria-label="Select all flights"
                    checked={allFlightsSelected}
                    onChange={onToggleAllFlights}
                  />
                </th>
              )}
              <th className="p-4">Flight Number</th>
              <th className="p-4">Departure</th>
              <th className="p-4">Arrival</th>
              <th className="p-4">Price</th>
            </tr>
          </thead>
          <tbody>
            {flights.map((flight, index) => (
              <tr
                key={getFlightKey(flight, index)}
                className="border-b border-slate-800 transition-colors hover:bg-slate-800/60"
              >
                {showSelection && (
                  <td className="p-4">
                    <input
                      type="checkbox"
                      aria-label={`Select flight ${flight.flightNumber}`}
                      checked={selectedFlightIds.includes(getFlightKey(flight, index))}
                      onChange={() => onToggleFlight?.(getFlightKey(flight, index))}
                    />
                  </td>
                )}
                <td className="p-4">{flight.flightNumber}</td>
                <td className="p-4">{flight.departureAirport}</td>
                <td className="p-4">{flight.arrivalAirport}</td>
                <td className="p-4 font-medium text-emerald-400">
                  ${flight.price}
                </td>
              </tr>
            ))}
          </tbody>
        </table>
    </div>
  );
}