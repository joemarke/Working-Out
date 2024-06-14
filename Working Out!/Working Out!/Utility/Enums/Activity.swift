//
//  Activity.swift
//  Working Out!
//
//  Created by Joe Marke on 02/04/2024.
//

import SwiftUI

enum Activity: String, CaseIterable, Codable {
    case run = "Run"
    case strength = "Strength"
    case rest = "Rest"
    
    func getImageName() -> String {
        switch self {
        case .run:
            return "figure.run"
        case .strength:
            return "figure.strengthtraining.traditional"
        case .rest:
            return "figure.mind.and.body"
        }
    }
    
    func getBackgroundColor() -> Color {
        switch self {
        case .run:
            return .run
        case .strength:
            return .strength
        case .rest:
            return .rest
        }
    }
    
    func getButtonText() -> String {
        switch self {
        case .run:
            "I Ran Today"
        case .strength:
            "I Lifted Today"
        case .rest:
            "I Rested Today"
        }
    }
}
