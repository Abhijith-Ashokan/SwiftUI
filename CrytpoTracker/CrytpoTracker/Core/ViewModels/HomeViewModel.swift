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
    
    @Published var statistics: [Statistics] = []
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers () {
        
        //update allCoins
        $searchBarText
            .combineLatest(coinDataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink {[weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellable)
        
        //update MarketData
        marketDataService.$marketData
        
            .map { (marketDataModel) -> [Statistics] in
                var stats: [Statistics] = []
                
                guard let data = marketDataModel else {
                    return stats
                }
                
                let marketcap = Statistics(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
                let volume = Statistics(title: "24h Volume", value: data.volume)
                let btcDominance = Statistics(title: "BTC Dominance", value: data.btcDominance)
                let portfolio = Statistics(title: "Portfolio Value", value: "₹0.00")
                
                stats.append(contentsOf: [marketcap,volume,btcDominance,portfolio])
                return stats
            }
            .sink {[weak self] returnedStats in
                self?.statistics = returnedStats
            }
            .store(in: &cancellable)
        
        //update portfolioCoins
        
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map { (coinModels, portfolioEntities) -> [Coin] in
                coinModels
                    .compactMap { coin -> Coin? in
                        guard let entity = portfolioEntities.first(where: { $0.coinID == coin.id}) else { return nil }
                        return coin.updateHolding(amount: entity.amount)
                    }
                
            }
            .sink { [weak self] (returnedCoins) in
                self?.portfolioCoins = returnedCoins
            }
            .store(in: &cancellable)
        
    }
    
    func updatePorfolio(coin: Coin, amount: Double) {
        portfolioDataService.upadtePortfolio(coin: coin, amount: amount)
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
