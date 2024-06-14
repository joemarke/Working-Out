//
//  ActivitiesView.swift
//  Working Out!
//
//  Created by Joe Marke on 02/04/2024.
//

import SwiftUI
import ConfettiSwiftUI

struct ActivitiesView: View {
    @Environment(\.scenePhase) var scenePhase
    @AppStorage("activityDetails") var activityDetails = [ActivityDetails]()
    @State private var confettiCounter = 0
    @State private var latestActivity: ActivityDetails?
    let columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 8), count: 6)
    var extraActivityDays: Int {
        6 - activityDetails.count % 6
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                LazyVGrid(columns: columns, spacing: 24) {
                    ForEach(1...extraActivityDays, id: \.self) { _ in
                        Color.clear
                    }
                    ForEach(Array(zip(activityDetails.indices, activityDetails)), id: \.0) { index, item in
                        Menu {
                            ForEach(Activity.allCases, id: \.self) { activity in
                                Button(activity.rawValue) {
                                    withAnimation {
                                        activityDetails[index] = .init(activity: activity, date: activityDetails[index].date)
                                    }
                                }
                            }
                        } label: {
                            CalendarDayComponent(activityDetails: item)
                        }
                    }
                }
                
                if let latestActivity, latestActivity.date.isSameDay(as: .now) {
                    yippee()
                } else {
                    TodaysActivitiesComponent(confettiCounter: $confettiCounter, lastSixDays: activityDetails.suffix(6))
                }
            }
            .padding(8)
        }
        .onAppear {
            print(activityDetails)
            fillInMissingDates()
        }
        .onChange(of: activityDetails) {
            latestActivity = activityDetails.last
        }
        .onChange(of: scenePhase) {
            if scenePhase == .active {
                latestActivity = activityDetails.last
            }
        }
        .refreshable {
            latestActivity = activityDetails.last
        }
        .defaultScrollAnchor(.bottom)
        .confettiCannon(counter: $confettiCounter, num: 300, colors: [.buttonPink, .buttonYellow, .error, .run, .rest, .strength], confettiSize: 10, rainHeight: 1000, radius: 400)
        .sensoryFeedback(.success, trigger: confettiCounter)
    }
}

#Preview {
    ActivitiesView()
}

extension ActivitiesView {
    struct TodaysActivitiesComponent: View {
        @AppStorage("activityDetails") var activityDetails = [ActivityDetails]()
        @State private var selectedActivity: Activity?
        @Binding var confettiCounter: Int
        let todaysActivities: [Activity]
        
        init(confettiCounter: Binding<Int>, lastSixDays: [ActivityDetails]) {
            let manager = TodaysActivityManager(lastSixDays: lastSixDays)
            todaysActivities = manager.getTodaysActivities()
            self._confettiCounter = confettiCounter
        }
        
        var body: some View {
            VStack(spacing: 24) {
                HStack(alignment: .bottom, spacing: 24) {
                    ForEach(todaysActivities, id: \.self) { activity in
                        CalendarDayComponent(activityDetails: .init(activity: activity, date: .now), isLarge: selectedActivity == activity)
                            .frame(width: selectedActivity == activity ? 141 : 56)
                            .onTapGesture {
                                withAnimation {
                                    selectedActivity = activity
                                }
                            }
                    }
                }
                
                VStack(spacing: 16) {
                    if let selectedActivity {
                        logActivityButton(activity: selectedActivity)
                    }
                    
                    if todaysActivities.count < 3 {
                        secondaryLogActivityButton()
                    }
                }
            }
            .onAppear {
                selectedActivity = todaysActivities.first
            }
            .onChange(of: activityDetails) {
                selectedActivity = todaysActivities.first
            }
        }
        
        private func logActivityButton(activity: Activity) -> some View {
            Button {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    confettiCounter += 1
                    withAnimation {
                        activityDetails.append(.init(activity: activity, date: .now))
                        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [NotificationDetails.afternoonNotification, NotificationDetails.eveningNotification])
                    }
                }
            } label: {
                Text(activity.getButtonText())
                    .foregroundStyle(.white)
                    .font(.custom(FontNames.foundersGroteskSemibold, size: 17))
                    .padding(.vertical, 16)
                    .padding(.horizontal, 32)
                    .background(LinearGradient(colors: [.buttonYellow, .buttonPink],
                                               startPoint: .topLeading,
                                               endPoint: .bottomTrailing))
                    .clipShape(RoundedRectangle(cornerRadius: 4))
            }
        }
        
        private func secondaryLogActivityButton() -> some View {
            Menu {
                ForEach(Activity.allCases, id: \.self) { activity in
                    if !todaysActivities.contains(activity) {
                        Button(activity.rawValue) {
                            withAnimation {
                                activityDetails.append(.init(activity: activity, date: .now, isOffSchedule: true))
                                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [NotificationDetails.afternoonNotification, NotificationDetails.eveningNotification])
                            }
                        }
                    }
                }
            } label: {
                Text("Log Other Activity")
                    .font(.custom(FontNames.foundersGroteskRegular, size: 15))
                    .foregroundStyle(.primaryText.opacity(0.8))
            }
        }
    }
}

extension ActivitiesView {
    private func yippee() -> some View {
        VStack(spacing: 12) {
            HStack {
                Spacer()
                Text("✨")
                Spacer()
                Text("✨")
                Spacer()
            }
            .font(.system(size: 50))
            
            HStack {
                Spacer()
                Text("✨")
                    .font(.system(size: 42))
                Spacer()
                Text("Yippee!!!")
                    .font(.custom(FontNames.foundersGroteskSemibold, size: 48))
                    .foregroundStyle(.primaryText)
                Spacer()
                Text("✨")
                    .font(.system(size: 42))
                Spacer()
            }
            
            HStack {
                Spacer()
                Text("✨")
                Spacer()
                Text("✨")
                Spacer()
            }
            .font(.system(size: 50))
        }
        .padding(.bottom, 32)
    }
    
    private func fillInMissingDates() {
        activityDetails.sort()
        
        if activityDetails.count > 1 {
            let minDate = activityDetails.first!.date
            let maxDate = Date.now
            
            var currentDate = minDate
            
            while currentDate <= maxDate {
                if !activityDetails.contains(where: { $0.date.isSameDay(as: currentDate) }) && !currentDate.isSameDay(as: .now) {
                    activityDetails.append(.init(activity: nil, date: currentDate))
                }
                currentDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!
            }
            
            activityDetails.sort()
        }
    }
    
    // CAN BE REMOVED – Dummy data only
    private func getRandomDetails() -> [ActivityDetails] {
        func getActivity(_ int: Int) -> Activity? {
            if int <= 3 {
                return .run
            } else if int <= 7 {
                return .strength
            } else if int <= 9 {
                return .rest
            }
            
            return nil

        }
        var details = [ActivityDetails]()
        (1...63).forEach { int in
            let rand = Int.random(in: 1...10)
            details.append(.init(activity: getActivity(rand), date: .now.getDateIn(days: -int)))
        }
        return details
    }
}
