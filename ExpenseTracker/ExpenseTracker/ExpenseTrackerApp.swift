//
//  ExpenseTrackerApp.swift
//  ExpenseTracker
//
//  Created by Aoole on 22/02/24.
//

import SwiftUI

@main
struct ExpenseTrackerApp: App {
    @StateObject var transactionsListVM = TransactionsListViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(transactionsListVM)
        }
    }
}
