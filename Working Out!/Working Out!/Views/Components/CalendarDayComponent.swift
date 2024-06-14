//
//  CalendarDayComponent.swift
//  Working Out!
//
//  Created by Joe Marke on 02/04/2024.
//

import SwiftUI

struct CalendarDayComponent: View {
    let activityDetails: ActivityDetails
    var isLarge = false
    
    var body: some View {
        if let activity = activityDetails.activity {
            VStack(alignment: .leading, spacing: 4) {
                Text(activityDetails.date.getDayOfWeek())
                    .font(isLarge ? .custom(FontNames.foundersGroteskMedium, size: 32) : .custom(FontNames.foundersGroteskRegular, size: 17))
                    .foregroundStyle(.black.opacity(0.8))
                
                Text(activityDetails.date.getDayNumber())
                    .font(.custom(FontNames.foundersGroteskLight, size: isLarge ? 32 : 17))
                    .foregroundStyle(.black.opacity(0.8))
                
                Spacer()
                
                Image(systemName: activity.getImageName())
                    .font(isLarge ? .system(size: 48, weight: .semibold) : .headline)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.black.opacity(0.8))
                
                Spacer()
            }
            .padding(isLarge ? 16 : 4)
            .frame(height: isLarge ? 257 : 102)
            .overlay(alignment: .bottomTrailing) {
                if activityDetails.isOffSchedule {
                    RightAngleTriangle()
                        .foregroundStyle(.error)
                        .frame(width: 30, height: 30)
                }
            }
            .background(activity.getBackgroundColor())
            .clipShape(RoundedRectangle(cornerRadius: isLarge ? 12 : 4))
        } else {
            Text("+")
                .font(.custom(FontNames.foundersGroteskRegular, size: 32))
                .foregroundStyle(Color.primaryText.opacity(0.4))
                .frame(height: 102)
                .frame(maxWidth: .infinity)
                .background {
                    RoundedRectangle(cornerRadius: 4)
                        .strokeBorder(.primaryText.opacity(0.4), style: .init(lineWidth: 1, dash: [4]))
                }
        }
        
    }
}

#Preview {
    VStack {
        CalendarDayComponent(activityDetails: .init(activity: .run, date: .now, isOffSchedule: false), isLarge: false)
            .frame(width: 56)
        
        CalendarDayComponent(activityDetails: .init(activity: nil, date: .now, isOffSchedule: false), isLarge: false)
            .frame(width: 56)
        
        CalendarDayComponent(activityDetails: .init(activity: .run, date: .now, isOffSchedule: false), isLarge: true)
            .frame(width: 141)
    }
}
