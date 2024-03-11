//
//  CircleButtonAnimation.swift
//  CrytpoTracker
//
//  Created by Abhijith on 04/03/24.
//

import SwiftUI

struct CircleButtonAnimation: View {
    
    //Ripple effect button animation
    
    @Binding var animate: Bool
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 5)
            .scale(animate ? 1.0 : 0)
            .opacity(animate ? 0 : 1)
            .animation(animate ? Animation.easeInOut(duration: 0.7) : .none, value: UUID())
    }
}

#Preview {
    CircleButtonAnimation(animate: .constant(false))
        .frame(width: 100, height: 100)
        .foregroundStyle(Color(.red))
}
