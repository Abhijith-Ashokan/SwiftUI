//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Aoole on 22/02/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            ScrollView {
                VStack{
                    // MARK: Title
                    Text("OverView")
                        .font(.title2)
                        .bold()
                    
                }
                .padding()
                .frame(maxWidth: .infinity)
            }
            .background(Color.backgroundColor)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // MARK: Notification Icon
                ToolbarItem {
                    Image(systemName: "bell.badge")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(Color.iconColor, .primary)
                }
            }
        }
        .navigationViewStyle(.stack)
        
    }
}

#Preview {
    ContentView()
}
