//
//  HomeViewModel.swift
//  CrytpoTracker
//
//  Created by Abhijith on 06/03/24.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    
    @Published var allCoins: [Coin] = []
    @Published var portfolioCoins: [Coin] = []
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.allCoins.append(DeveloperPreview.instance.coin)
            self.portfolioCoins.append(DeveloperPreview.instance.coin)
        }
        self.portfolioCoins = portfolioCoins
    }
    
}
