//
//  User.swift
//  Appetizers
//
//  Created by Abhijith on 01/03/24.
//

import Foundation

struct User: Codable {
    var firstName = ""
    var lastName = ""
    var email = ""
    var dob = Date()
    var extraNapkins = false
    var frequentRefils = false
}
