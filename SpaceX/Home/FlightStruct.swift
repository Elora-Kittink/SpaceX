//
//  FlightStruct.swift
//  SpaceX
//
//  Created by Elora on 26/09/2022.
//

import Foundation

// MARK: - WelcomeElement
struct FlightStruct: Decodable {
   
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
    
    // MARK: - Fairings
    struct Fairings: Decodable {
        let recovered: Bool?
    }
    
    // MARK: - Core
    struct Core: Decodable {
        enum CodingKeys: String, CodingKey {
            case landingSuccess = "landing_success", reused
        }
        let reused: Bool?
        let landingSuccess: Bool?
    }
    
    enum CodingKeys: String, CodingKey {
        case flightNumber = "flight_number",
             dateUnix = "date_unix", links, success,
             details, name, upcoming, cores, id, fairings
    }
    
    let flightNumber: Int
    let dateUnix: Double
    let links: Links
    let success: Bool?
    let details: String?
    let name: String
    let upcoming: Bool
    let cores: [Core]
    let id: String
    let fairings: Fairings?
}
