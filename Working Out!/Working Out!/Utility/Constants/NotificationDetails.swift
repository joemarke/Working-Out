//
//  NotificationDetails.swift
//  Working Out!
//
//  Created by Joe Marke on 03/04/2024.
//

import Foundation

struct NotificationDetails {
    static let afternoonNotification = "afternoonNotification"
    static let eveningNotification = "eveningNotification"
    static let afternoonRunNotificationOptions = [("Run Tonite 👀", "Run tonight queen??"),
                                                  ("Zoomies? Get Your Boots On", "Time to run sprinter. Attaboy!"),
                                                  ("Literally Training For A Half Marathon", "Just do a run bro. Just run bro just do it bro"),
                                                  ("🏃🏽‍♂️🏃🏽‍♂️🏃🏽‍♂️", "Go white boy go!!!!"),
                                                  ("Run From Home Not Problems", "🤣🤣🤣🤣 that was for your millennial coworkers"),
                                                  ("Little Runner Boy", "Pa rum pum pum pum"), 
                                                  ("If You're Not Running", "You're not stunning!!!!! 💅"),
                                                  ("Not A Toxic One Today", "Just go for a run pal")]
    static let afternoonStrengthNotificationOptions = [("Strength Tonite 👀", "Strength tonight queen??"),
                                                       ("Get Large Big Dog", "Large man incoming. Pick up those weights prince"),
                                                       ("Lifting Is Grifting", "A combination of grafting and peter griffin. Fornite griddy Ya!"),
                                                       ("You're weak", "Couldn't even lift a common box. Strength today small fry"),
                                                       ("Get Pumped", "No creatine just vibes"),
                                                       ("You Will Never Find Love With Small Muscles", "No need for that. Lifting time!"),
                                                       ("You Would Rather Wait Than Weight", "Get off your ass. Pathetic"),
                                                       ("Two Dumbbells, One Guy", "Nothing erotic about it. Hit it!")]
    static let afternoonRestNotificationOptions = [("Rest Tonite 👀", "Rest tonight queen??"),
                                                   ("Rest Easy King", "Keep it breezy big dog"),
                                                   ("Take A Break", "Come away with us for the summer (yogi jessica)"),
                                                   ("My God You've Been Working Hard", "Time to stretch those massive calves"),
                                                   ("Relax....", "It's chillin time"),
                                                   ("Chillbo Baggins", "Recovery is calling your name. Like the shire?? never seen it"),
                                                   ("Resticles Testicles", "absolutely foul... take a chill pill")]
    static let eveningLogNotificationOptions = [("Don't Forget To Log!!!", "If you do it messes with the suggestions lol"),
                                                ("Logging Tonite 👀", "Logging tonight queen??"),
                                                ("Did You Even Workout Today?", "You'd be a failure if not. Either way you gotta log something"),
                                                ("Log In", "What is this FACEBOOK 🤣. Log your workout champ"),
                                                ("I Know What You Did Today", "Just kidding i don't!! because you haven't logged it yet!!!!!"),
                                                ("Time To See That Sweet Yippee", "Sparkle time!!!!")]
    
    static func getAfternoonNotificationDetails(activity: Activity) -> (String, String) {
        switch activity {
        case .run:
            let rand = Int.random(in: 0..<afternoonRunNotificationOptions.count)
            return afternoonRunNotificationOptions[rand]
        case .strength:
            let rand = Int.random(in: 0..<afternoonStrengthNotificationOptions.count)
            return afternoonStrengthNotificationOptions[rand]
        case .rest:
            let rand = Int.random(in: 0..<afternoonRestNotificationOptions.count)
            return afternoonRestNotificationOptions[rand]
        }
    }
    
    static func getEveningNotificationDetails() -> (String, String) {
        let rand = Int.random(in: 0..<eveningLogNotificationOptions.count)
        return eveningLogNotificationOptions[rand]
    }
}
