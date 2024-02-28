//
//  AppetizerListViewModel.swift
//  Appetizers
//
//  Created by Abhijith on 28/02/24.
//

import SwiftUI

final class AppetizerListViewModel: ObservableObject {
    
    @Published  var appetizers :[Appetizer] = []
    
    func getAppetizersList () {
        NetworkManager.shared.getAppetizers { result in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let appetizers) :
                    self.appetizers = appetizers
                case .failure(let error) :
                    print("Error:\(error.localizedDescription)")
                    
                }

            }
        }
    }
    
}
