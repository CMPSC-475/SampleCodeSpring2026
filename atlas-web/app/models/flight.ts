export type Flight = {
    flightNumber: string;
    departureAirport: string;
    arrivalAirport: string;
    price: number;
  };

  export const getFlightKey = (
    flight: Flight,
    index: number
  ): string => `${flight.flightNumber}-${index}`;
  
  export const emptyFlight = (): Flight => ({
    flightNumber: "",
    departureAirport: "",
    arrivalAirport: "",
    price: 0,
  });
  
  export const sampleFlights: Flight[] = [
    {
      flightNumber: "123456",
      departureAirport: "JFK",
      arrivalAirport: "LAX",
      price: 100,
    },
    {
      flightNumber: "123457",
      departureAirport: "JFK",
      arrivalAirport: "ORD",
      price: 120,
    },
    {
      flightNumber: "123458",
      departureAirport: "JFK",
      arrivalAirport: "MIA",
      price: 140,
    },
  ];
  