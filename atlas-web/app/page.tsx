import Image from "next/image";
import { Flight } from "./models/flights";

export default function Home() {
  const flights = [
    {
      "fightNumber" : 1234,
      "depart" : "JFK",
      "arrival": "LAX",
      "price" : 200
    },
    {
      "fightNumber" : 1234,
      "depart" : "JFK",
      "arrival": "LAX",
      "price" : 200
    },
    {
      "fightNumber" : 1234,
      "depart" : "JFK",
      "arrival": "LAX",
      "price" : 200
    }
  ]
  return (
    <div className="p-8">
      <h1 className="text-center text-3xl font-bold"> Available Flights</h1>

      <table className="w-full text-left">
        <thead>
          <tr>
            <th>Flight Number</th>
            <th>Departure</th>
            <th>Arrival</th>
            <th>Price</th>
          </tr>
        </thead>
        <tbody>
          {flights.map((flight, index) => (
            <tr>
              <td> {flight.fightNumber}</td>
              <td> {flight.depart}</td>
              <td> {flight.arrival}</td>
              <td> {flight.price}</td>
            </tr>
          ))

          }
        </tbody>
      </table>
    
    </div>
  );
}
