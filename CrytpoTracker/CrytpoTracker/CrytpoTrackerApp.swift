//
//  CrytpoTrackerApp.swift
//  CrytpoTracker
//
//  Created by Aoole on 04/03/24.
//

import SwiftUI

@main
struct CrytpoTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .toolbar(.hidden)
            }
            
        }
    }
}
