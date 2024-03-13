//
//  CrytpoTrackerApp.swift
//  CrytpoTracker
//
//  Created by Abhijith on 04/03/24.
//

import SwiftUI

@main
struct CrytpoTrackerApp: App {
    
    @StateObject private var homeVM = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .toolbar(.hidden)
            }
            .environmentObject(homeVM)
        }
    }
}
