//
//  HomeService.swift
//  SpaceX
//
//  Created by Elora on 26/09/2022.
//

import Foundation

enum GlobalError: LocalizedError {
    
    case urlApiNotCreated,
         dataNotFound
    
    var errorDescription: String? {
        switch self {
        case .urlApiNotCreated:
            return "URL Api Not Created"
        case .dataNotFound:
            return "Data Not Found"
        }
    }
}

protocol HomeServiceDelegate: AnyObject {
    func didFinish(result: Flightcase)
    func didFail(error: Error)
}


struct Flightcase {
    
    let upcoming: [FlightStruct]
    let past: [FlightStruct]
}

class HomeService {
    
   weak var delegate: HomeServiceDelegate!

    init(delegate: HomeServiceDelegate) {
        self.delegate = delegate
    }
    

    func fetchFlights() async {
        var flights: [FlightStruct] = []
        guard let url = URL(string: "https://api.spacexdata.com/v5/launches") else {
            self.delegate.didFail(error: GlobalError.urlApiNotCreated)
            return }
        do {
             flights = try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<[FlightStruct], Error>) in
                let task = URLSession.shared.dataTask(with: url) { data, response, error in
                    guard let data = data, let response = response else {
                        let error = error ?? URLError(.badServerResponse)
                        continuation.resume(throwing: error)
                        return
                    }
                    do {
                        let decodedResult = try JSONDecoder().decode([FlightStruct].self, from: data)
                        continuation.resume(returning: decodedResult)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                }
                task.resume()
            }
            var upcoming: [FlightStruct] = []
            var past: [FlightStruct] = []
            
            flights.forEach { flight in
                flight.upcoming ? upcoming.append(flight) : past.append(flight)
            }
            
            print(upcoming)
            print(past)
            self.delegate.didFinish(result: Flightcase(upcoming: upcoming, past: past))
        } catch {
            self.delegate.didFail(error: error)
        }
    }
}
