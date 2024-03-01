//
//  AppetizersApp.swift
//  Appetizers
//
//  Created by Abhijith on 27/02/24.
//

import SwiftUI

@main
struct AppetizersApp: App {
    
    var order = Order()

    var body: some Scene {
        WindowGroup {
            AppetizerTabView().environmentObject(order)

        }
    }
}
