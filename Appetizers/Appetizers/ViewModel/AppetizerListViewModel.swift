//
//  AppetizerListViewModel.swift
//  Appetizers
//
//  Created by Abhijith on 28/02/24.
//

import SwiftUI

final class AppetizerListViewModel: ObservableObject {
    
    @Published  var appetizers :[Appetizer] = []
    @Published var alertItem: AlertItem?
    @Published var isLoading = false
    
    func getAppetizersList () {
        
        isLoading = true
        
        NetworkManager.shared.getAppetizers { [self] result in
            
            DispatchQueue.main.async { [self] in
    
                isLoading = false
                
                switch result {
                case .success(let appetizers) :
                    self.appetizers = appetizers
                    
                case .failure(let error) :
                    switch error {
                    case .invalidData:
                        alertItem = AlertContext.invalidData
                        
                    case .invalidURL:
                        alertItem = AlertContext.invalidURL
                        
                    case .invalidResponse:
                        alertItem = AlertContext.invalidResonse
                        
                    case .unableToComplete:
                        alertItem = AlertContext.unableToComplete
                    }
                    
                }

            }
        }
    }
    
}
