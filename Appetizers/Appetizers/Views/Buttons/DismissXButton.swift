//
//  DismissXButton.swift
//  Appetizers
//
//  Created by Aoole on 29/02/24.
//

import SwiftUI

struct DismissXButton: View {
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 30, height: 30)
                .foregroundStyle(Color(.white))
                .opacity(0.6)
            Image(systemName: "xmark")
                .imageScale(.small)
                .frame(width: 44,height: 44)
                .foregroundStyle(Color(.black))

        }
    }
}

#Preview {
    DismissXButton()
}
