//
//  Color.swift
//  CrytpoTracker
//
//  Created by Abhijith on 04/03/24.
//

import SwiftUI

extension Color {
    
    static let theme = ColorTheme()
}

struct ColorTheme {
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let green = Color("ThemeGreenColor")
    let red = Color("ThemeRedColor")
    let secondaryText = Color("SecondaryTextColor")
}
