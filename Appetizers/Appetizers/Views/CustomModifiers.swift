//
//  CustomModifiers.swift
//  Appetizers
//
//  Created by Abhijith on 01/03/24.
//

import SwiftUI

struct StandardButtonStyle: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .buttonStyle(.bordered)
            .tint(.greenPrimary)
            .controlSize(.large)
    }
}

