//
//  TodaysActivityManager.swift
//  Working Out!
//
//  Created by Joe Marke on 02/04/2024.
//

import SwiftUI

struct TodaysActivityManager {
    let lastSixDays: [ActivityDetails]
    
    init(lastSixDays: [ActivityDetails]) {
        self.lastSixDays = lastSixDays
    }
    
    var lastSixActivities: [Activity?] {
        lastSixDays.map({ $0.activity })
    }
    
    private func getCount(for type: Activity) -> Int {
        lastSixActivities.filter { $0 == type }.count
    }

    private func getLast(_ count: Int) -> [Activity?] {
        lastSixActivities.suffix(count)
    }

    private func remove(_ type: Activity, from options: inout [Activity]) {
        if let index = options.firstIndex(where: { $0 == type }) {
            options.remove(at: index)
        }
    }

    private func prioritise(_ type: Activity, for options: inout [Activity]) {
        if let index = options.firstIndex(where: { $0 == type }) {
            options.remove(at: index)
            options.insert(type, at: 0)
        }
    }

    func getTodaysActivities() -> [Activity] {
        let requiredRuns = 2
        let requiredStrengths = 3
        let maxRestsPerWeek = 2
        let maxWorkoutsBeforeRest = 4
        var workoutOptions: [Activity] = [.run, .strength, .rest]
        
        if lastSixActivities.count >= maxWorkoutsBeforeRest {
            if !getLast(maxWorkoutsBeforeRest).contains(.rest) && !getLast(maxWorkoutsBeforeRest).contains(nil) {
                return [.rest]
            }
        }
        
        if getCount(for: .rest) >= maxRestsPerWeek {
            remove(.rest, from: &workoutOptions)
        }
        
        if getLast(1) == [.rest] {
            remove(.rest, from: &workoutOptions)
            prioritise(.run, for: &workoutOptions)
        }
        
        if getLast(2) == [.strength, .strength] {
            remove(.strength, from: &workoutOptions)
        }
        
        if getLast(2) == [.run, .run] {
            remove(.run, from: &workoutOptions)
        }
        
        if getLast(1) == [.run] {
            prioritise(.strength, for: &workoutOptions)
        }
        
        if getCount(for: .strength) < requiredStrengths {
            prioritise(.strength, for: &workoutOptions)
        }
        
        if getCount(for: .run) < requiredRuns {
            prioritise(.run, for: &workoutOptions)
        }
        
        if lastSixActivities.count >= maxWorkoutsBeforeRest - 1 {
            if !getLast(maxWorkoutsBeforeRest - 1).contains(.rest) && !getLast(maxWorkoutsBeforeRest - 1).contains(nil) {
                prioritise(.rest, for: &workoutOptions)
            }
        }
        
        return workoutOptions
    }
}
