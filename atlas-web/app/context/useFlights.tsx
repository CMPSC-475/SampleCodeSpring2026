"use client";

import {
  createContext,
  useContext,
  useState,
  ReactNode,
} from "react";

import { type Flight } from "../models/flight";

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

export function FlightsProvider({
  children,
}: FlightsProviderProps) {
  const [flights, setFlights] = useState<Flight[]>([]);

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