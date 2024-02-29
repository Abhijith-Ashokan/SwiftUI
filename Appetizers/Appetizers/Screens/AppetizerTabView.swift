//
//  ContentView.swift
//  Appetizers
//
//  Created by Abhijith on 27/02/24.
//

import SwiftUI

struct AppetizerTabView: View {
    var body: some View {

        TabView {
            AppetizerListView()
                .tabItem {
                    Image(systemName: "house")
                        .environment(\.symbolVariants, .none)
                    Text("Home")
                }
            AccountView()
                .tabItem {
                    Image(systemName: "person")
                        .environment(\.symbolVariants, .none)
                    Text("Account")
                }
            OrderView()
                .tabItem {
                    Image(systemName: "bag")
                        .environment(\.symbolVariants, .none)
                    Text("Order")
                }
        }
        .tint(Color.primaryGreen)
    }
}

#Preview {
    AppetizerTabView()
}
