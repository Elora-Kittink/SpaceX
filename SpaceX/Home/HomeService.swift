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
        guard let url = URL(string: "https://api.spacexdata.com/v5/launches") else {
            self.delegate.didFail(error: GlobalError.urlApiNotCreated)
            return
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            let flights = try JSONDecoder().decode([FlightStruct].self, from: data)
        // TODO: - Optimiser le tri
            let upcoming = flights.filter { $0.upcoming }
            let past = flights.filter { !$0.upcoming }
            self.delegate.didFinish(result: Flightcase(upcoming: upcoming,
                                                       past: past))
            
        } catch {
            self.delegate.didFail(error: error)
            print(error)
        }
    }
}
