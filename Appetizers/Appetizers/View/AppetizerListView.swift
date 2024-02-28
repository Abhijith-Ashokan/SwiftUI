//
//  AppetizerListView.swift
//  Appetizers
//
//  Created by Abhijith on 27/02/24.
//

import SwiftUI

struct AppetizerListView: View {
    
    @StateObject var viewModel = AppetizerListViewModel()
    
    var body: some View {
        ZStack {
            NavigationView {
                
                List(viewModel.appetizers) { appetizer in
                    AppetizerListCell(appetizer: appetizer)
                }
                .navigationTitle("🌭 Appetizers")
            }
            .onAppear() {
                viewModel.getAppetizersList()
            }
            if viewModel.isLoading {
                LoadingView()
            }
        }
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: alertItem.title,
                  message: alertItem.message,
                  dismissButton: alertItem.dismissButton)
        }
        
    }
}

#Preview {
    AppetizerListView()
}
