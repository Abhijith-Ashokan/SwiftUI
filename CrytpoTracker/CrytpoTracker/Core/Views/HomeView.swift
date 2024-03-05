//
//  HomeView.swift
//  CrytpoTracker
//
//  Created by Abhijith on 04/03/24.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showPortfolio = false
    
    var body: some View {
        ZStack {
            
            //background layer
            Color.theme.background
                .ignoresSafeArea()
            
            //content layer
            VStack {
                homeHeader
                Spacer(minLength: 0)
            }
            
        }
    }
}

#Preview {
    NavigationView {
        HomeView()
            .toolbar(.hidden)
    }
    
}

extension HomeView {
    private var homeHeader: some View {
        HStack {
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .animation(nil, value: UUID())
                .background(
                CircleButtonAnimation(animate: $showPortfolio))
            Spacer()
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundStyle(Color.theme.accent)
                .animation(nil, value: UUID())
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring) {
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
}
