"use client";

import {
  createContext,
  useContext,
  useState,
  useEffect,
  ReactNode,
} from "react";

import { sampleFlights, type Flight } from "../models/flight";

// describes what subscribes get from context
type FlightsContextType = {
  flights: Flight[];
  setFlights: React.Dispatch<React.SetStateAction<Flight[]>>;
};

// the actual context object. it's created with a default value of undefined
// the undefined is used to indicate that the context is not yet initialized
const FlightsContext = createContext<FlightsContextType | undefined>(
  undefined
);

type FlightsProviderProps = {
  children: ReactNode;
};

const FLIGHTS_STORAGE_KEY = "atlas.flights";

export function FlightsProvider({
  children,
}: FlightsProviderProps) {
  const [flights, setFlights] = useState<Flight[]>(sampleFlights);
  const [isHydrated, setIsHydrated] = useState(false);

  useEffect(() => {
    try {
      const storedFlights = localStorage.getItem(FLIGHTS_STORAGE_KEY);
      if (storedFlights) {
        const parsedFlights = JSON.parse(storedFlights);
        if (Array.isArray(parsedFlights)) {
          setFlights(parsedFlights);
        }
      }
    } catch {
      // Keep sample flights when storage data is invalid.
    } finally {
      setIsHydrated(true);
    }
  }, []);

  useEffect(() => {
    if (!isHydrated) return;
    localStorage.setItem(FLIGHTS_STORAGE_KEY, JSON.stringify(flights));
  }, [flights, isHydrated]);

  return (
    <FlightsContext.Provider value={{ flights, setFlights }}>
      {children}
    </FlightsContext.Provider>
  );
}

export function useFlights(): FlightsContextType {
  const context = useContext(FlightsContext);

  if (!context) {
    throw new Error(
      "useFlights must be used inside FlightsProvider"
    );
  }

  return context;
}