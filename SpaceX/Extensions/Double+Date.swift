//
//  Double+Date.swift
//  SpaceX
//
//  Created by Elora on 20/10/2022.
//

import Foundation


extension Double {
    func convertDate() -> String {
        let date = Date(timeIntervalSince1970: self)
        let formatter = DateFormatter()
        formatter.timeZone = .current
        formatter.locale = .current
        formatter.dateFormat = "dd MMMM yyyy"
        return formatter.string(from: date)
    }
}
