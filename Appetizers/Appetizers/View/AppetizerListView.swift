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
        NavigationView {
            
            List(viewModel.appetizers) { appetizer in
                AppetizerListCell(appetizer: appetizer)
            }
   
            
            .navigationTitle("🌭 Appetizers")
        }
        .onAppear() {
            viewModel.getAppetizersList()
        }
    }
}

#Preview {
    AppetizerListView()
}
