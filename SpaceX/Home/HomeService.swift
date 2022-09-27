//
//  HomeService.swift
//  SpaceX
//
//  Created by Elora on 26/09/2022.
//

import Foundation

struct Flightcase {
    var upcoming: [FlightStruct]
    var past : [FlightStruct]
}

class HomeService {
    
    func fetchFlights() async -> (upcoming: [FlightStruct], past: [FlightStruct])? {
        let test: (upcoming: [FlightStruct], past: [FlightStruct])
        
        guard let url = URL(string: "https://api.spacexdata.com/v5/launches") else {
            return nil
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)
             let flights = try JSONDecoder().decode([FlightStruct].self, from: data)
           
            test.upcoming = flights.filter{$0.upcoming}
            test.past = flights.filter{!$0.upcoming}
            print(test.past)
            return test
        } catch {
            print(error)
            return nil
        }
    }
}
