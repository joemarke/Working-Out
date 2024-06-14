//
//  AppDelegate.swift
//  Working Out!
//
//  Created by Joe Marke on 04/04/2024.
//

import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    @AppStorage("activityDetails") var activityDetails = [ActivityDetails]()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                self.scheduleNotifications()
            }
        }
        
        return true
    }
    
    private func scheduleNotifications() {
        let manager = TodaysActivityManager(lastSixDays: activityDetails.suffix(6))
        let todaysActivities = manager.getTodaysActivities()
        let todaysPriority = todaysActivities.first
        
        let afternoonNotification = UNMutableNotificationContent()
        if let todaysPriority {
            let afternoonNotificationDetails = NotificationDetails.getAfternoonNotificationDetails(activity: todaysPriority)
            afternoonNotification.title = afternoonNotificationDetails.0
            afternoonNotification.body = afternoonNotificationDetails.1
        } else {
            afternoonNotification.title = "It's Workout Time Baby!!"
            afternoonNotification.body = "Time to get crazy prince!!! Yipppeeeeeeeee!"
        }
        
        let eveningNotification = UNMutableNotificationContent()
        let eveningNotificationDetails = NotificationDetails.getEveningNotificationDetails()
        eveningNotification.title = eveningNotificationDetails.0
        eveningNotification.body = eveningNotificationDetails.1
        
        if let isWorkoutCompleted = activityDetails.sorted().last?.date.isSameDay(as: .now) {
            if !isWorkoutCompleted {
                var dateComponent = DateComponents()
                
                dateComponent.hour = 16 // 4 pm
                var trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: true)
                var request = UNNotificationRequest(identifier: NotificationDetails.afternoonNotification, content: afternoonNotification, trigger: trigger)
                UNUserNotificationCenter.current().add(request)
                
                dateComponent.hour = 23 // 11 pm
                trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: true)
                request = UNNotificationRequest(identifier: NotificationDetails.eveningNotification, content: afternoonNotification, trigger: trigger)
                UNUserNotificationCenter.current().add(request)
            } else {
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [NotificationDetails.afternoonNotification, NotificationDetails.eveningNotification])
            }
        }
    }
}
