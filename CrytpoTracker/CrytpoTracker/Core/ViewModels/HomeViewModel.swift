//
//  HomeViewModel.swift
//  CrytpoTracker
//
//  Created by Abhijith on 06/03/24.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var allCoins: [Coin] = []
    @Published var portfolioCoins: [Coin] = []
    @Published var searchBarText = ""
    
    @Published var stats = [
    Statistics(title: "Title", value: "Value", percentageChange: 1),
    Statistics(title: "Title", value: "Value"),
    Statistics(title: "Title", value: "Value"),
    Statistics(title: "Portfolio", value: "Value", percentageChange: -23)
    ]
    
    private let dataService = CoinDataService()
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers () {
        
        $searchBarText
            .combineLatest(dataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink {[weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellable)
    }
    
    private func filterCoins(text: String, coins: [Coin]) -> [Coin] {
        
        guard !text.isEmpty else { return coins }
        
        let lowercasedText = text.lowercased()
        return coins.filter { coin in
            return coin.name.lowercased().contains(lowercasedText) ||
            coin.symbol.lowercased().contains(lowercasedText) ||
            coin.id.lowercased().contains(lowercasedText)
        }
    }
    
}
