//
//  FlightStruct.swift
//  SpaceX
//
//  Created by Elora on 26/09/2022.
//

import Foundation

// MARK: - WelcomeElement
struct FlightStruct: Decodable {
   
    enum CodingKeys: String, CodingKey {
        case flightNumber = "flight_number",
             dateUnix = "date_unix", links, success,
             details, name, upcoming, cores, id
    }
    
    let flightNumber: Int
    let dateUnix: Int
    let links: Links
    let success: Bool?
    let details: String?
    let name: String
    let upcoming: Bool
    let cores: [Core]
    let id: String
}

// MARK: - Core
struct Core: Decodable {
    enum CodingKeys: String, CodingKey {
        case landingSuccess = "landing_success", reused
    }
    let reused: Bool?
    let landingSuccess: Bool?
}


// MARK: - Fairings
struct Fairings: Decodable {
    let recovered: Bool?
}


// MARK: - Links
struct Links: Decodable {
    let patch: Patch
    let flickr: Flickr
}

// MARK: - Flickr
struct Flickr: Decodable {
    let original: [String]
}

// MARK: - Patch
struct Patch: Decodable {
    let small, large: String?
}





struct FlightStruct1: Decodable {
//    on veut : upcoming, id(ça sert toujours), name, date_local, flickr -> original[4] (image home) +
//    details, succes, cores -> landing_succes, cores -> reused, flight_number, flickr -> original[images] +
//    links -> patch -> small (logo de mission)
    enum CodingKeys: String, CodingKey {
        case flightNumber = "flight_number",
             dateUnix = "date_unix",
             cores, name, succes, upcoming, id,
             details, original
    }
    
    struct Core: Decodable {
        enum CodingKeys: String, CodingKey {
            case landingSuccess = "landing_success"
        }
        
        let landingSuccess: Bool
    }
    struct Links: Decodable {
        let patch: Patch
        let flickr: Flickr
    }
    struct Patch: Decodable {
        let small, large: String
    }
    struct Flickr: Decodable {
        let original: [String]
    }
    
    let flightNumber: Int
    let cores: [Core]
    let name: String
    let succes: Bool
    let upcoming: Bool!
    let id: String
    let dateUnix: Double
    let details: String
    let original: [String]
    var date: Date { Date(timeIntervalSince1970: TimeInterval(self.dateUnix)) }
}
