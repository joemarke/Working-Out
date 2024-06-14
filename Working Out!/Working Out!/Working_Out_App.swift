//
//  Working_Out_App.swift
//  Working Out!
//
//  Created by Joe Marke on 02/04/2024.
//

import SwiftUI

@main
struct Working_Out_App: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ActivitiesView()
        }
    }
}
