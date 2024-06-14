//
//  ActivityDetails.swift
//  Working Out!
//
//  Created by Joe Marke on 02/04/2024.
//

import Foundation

struct ActivityDetails: Codable, Comparable {
    static func < (lhs: ActivityDetails, rhs: ActivityDetails) -> Bool {
        lhs.date < rhs.date
    }
    
    let activity: Activity?
    let date: Date
    var isOffSchedule = false
}
