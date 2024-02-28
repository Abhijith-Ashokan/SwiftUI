//
//  Alert.swift
//  Appetizers
//
//  Created by Abhijith on 28/02/24.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
    
}

struct AlertContext {
    static let invalidData = AlertItem(title: Text("Server Error"),
                                       message: Text("Invalid server data. Contact support."),
                                       dismissButton: .default(Text("OK")))
    static let invalidResonse = AlertItem(title: Text("Server Error"),
                                       message: Text("Invalid server response. Contact support."),
                                       dismissButton: .default(Text("OK")))
    static let invalidURL = AlertItem(title: Text("Server Error"),
                                       message: Text("Invalid server URL. Contact support."),
                                       dismissButton: .default(Text("OK")))
    static let unableToComplete = AlertItem(title: Text("Server Error"),
                                       message: Text("Unable to complete your request. Please check your internet connection."),
                                       dismissButton: .default(Text("OK")))
}
