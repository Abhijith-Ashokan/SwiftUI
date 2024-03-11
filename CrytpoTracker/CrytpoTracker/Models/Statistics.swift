//
//  Statistics.swift
//  CrytpoTracker
//
//  Created by Abhijith on 11/03/24.
//

import Foundation

struct Statistics: Identifiable {
    let id = UUID().uuidString
    let title: String
    let value: String
    let percentageChange: Double?
    
    init(title: String, value: String, percentageChange: Double? = nil) {
        self.title = title
        self.value = value
        self.percentageChange = percentageChange
    }
}
