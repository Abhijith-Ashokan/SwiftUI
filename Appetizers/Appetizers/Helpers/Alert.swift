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
    
    //MARK: Network Alerts
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
    
    //MARK: Account Alerts
    static let invalidForm = AlertItem(title: Text("Invalid Form"),
                                       message: Text("Please fill out all requied fields."),
                                       dismissButton: .default(Text("OK")))
    static let invalidEmail = AlertItem(title: Text("invalid Email"),
                                       message: Text("Please enter a valid Email."),
                                       dismissButton: .default(Text("OK")))
    static let userSaveSuccess = AlertItem(title: Text("User Saved Successfully"),
                                       message: Text("Your personal info have been saved successfully"),
                                       dismissButton: .default(Text("OK")))
    static let invalidUserData = AlertItem(title: Text("Invalid User Data"),
                                       message: Text("Error saving or retreiving user profile."),
                                       dismissButton: .default(Text("OK")))
    
}
