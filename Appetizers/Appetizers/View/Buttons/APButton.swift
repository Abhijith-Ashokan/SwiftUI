//
//  APButton.swift
//  Appetizers
//
//  Created by Aoole on 29/02/24.
//

import SwiftUI

struct APButton: View {
    
    let title: LocalizedStringKey
    
    var body: some View {
        Text(title)
            .font(.title3)
            .fontWeight(.semibold)
            .frame(width: 260, height: 50)
            .foregroundStyle(Color(.white))
            .background(Color.primaryGreen)
            .cornerRadius(10)
    }
}

#Preview {
    APButton(title: "Sample Title")
}
