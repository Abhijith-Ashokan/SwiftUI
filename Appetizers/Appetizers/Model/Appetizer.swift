//
//  Appetizer.swift
//  Appetizers
//
//  Created by Abhijith on 27/02/24.
//

import Foundation

struct Appetizer: Decodable,Identifiable {
    let id: Int
    let name: String
    let description: String
    let price: Double
    let imageURL: String
    let calories: Int
    let carbs: Int
    let protein: Int
}

struct AppetizerResponse: Decodable {
    
    let request: [Appetizer]
}

struct MockData {
    
    static let sampleAppetizer = Appetizer(id: 1, name: "Asian Flank Steak", description: "Sample data", price: 12.99, imageURL: "https://seanallen-course-backend.herokuapp.com/images/appetizers/asian-flank-steak.jpg", calories: 1000, carbs: 300, protein: 50)
    static let appetizers = [sampleAppetizer, sampleAppetizer, sampleAppetizer,sampleAppetizer]
}
