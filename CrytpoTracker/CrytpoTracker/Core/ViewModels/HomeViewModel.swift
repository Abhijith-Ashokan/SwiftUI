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
    @Published var sortOption: SortOption = .holdings
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    enum SortOption {
        case rank, rankReversed, holdings, holdgingsReversed, price, priceReversed
    }
    
    func addSubscribers () {
        
        //update allCoins
        $searchBarText
            .combineLatest(coinDataService.$allCoins, $sortOption)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterAndSortCoins)
            .sink {[weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellable)
        
        //update portfolioCoins
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map(mapAllCoinsToPortfolioCoins)
            .sink { [weak self] (returnedCoins) in
                guard let self = self else { return }
                self.portfolioCoins = self.sortPortfolioCoinsIfNeeded(coins: returnedCoins)
            }
            .store(in: &cancellable)
        
        //update MarketData
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(mapGlobalMarketData)
            .sink {[weak self] returnedStats in
                self?.statistics = returnedStats
            }
            .store(in: &cancellable)
    }
    
    func updatePorfolio(coin: Coin, amount: Double) {
        portfolioDataService.upadtePortfolio(coin: coin, amount: amount)
    }
    
    func reloadData() {
        coinDataService.getCoins()
        marketDataService.getData()
    }
    
    private func filterAndSortCoins(text: String, coins: [Coin], sortOption: SortOption) -> [Coin] {
        var updatedCoins = self.filterCoins(text: text, coins: coins)
        sortCoins(coins: &updatedCoins, sortOption: sortOption)
        return updatedCoins
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
    
    private func sortCoins(coins: inout [Coin], sortOption: SortOption) {
        
        switch sortOption {
        case .rank, .holdings:
            coins.sort { $0.rank < $1.rank}
        case .rankReversed, .holdgingsReversed:
            coins.sort { $0.rank > $1.rank}
        case .price:
            coins.sort { $0.currentPrice < $1.currentPrice}
        case .priceReversed:
            coins.sort { $0.currentPrice > $1.currentPrice}
        }
    }
    
    private func sortPortfolioCoinsIfNeeded(coins: [Coin]) -> [Coin] {
        switch sortOption {
            
        case .holdings:
            return coins.sorted { $0.currentHoldingsValue > $1.currentHoldingsValue }
        case .holdgingsReversed:
            return coins.sorted { $0.currentHoldingsValue < $1.currentHoldingsValue }
        default:
            return coins
        }
    }
    
    private func mapGlobalMarketData(marketDataModel: MarketData?, portfolioCoins: [Coin]) -> [Statistics] {
        var stats: [Statistics] = []
        
        guard let data = marketDataModel else {
            return stats
        }
        
        let marketcap = Statistics(title: "Market Cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = Statistics(title: "24h Volume", value: data.volume)
        let btcDominance = Statistics(title: "BTC Dominance", value: data.btcDominance)
        
        let portfolioValue = portfolioCoins
            .map { $0.currentHoldingsValue}
            .reduce(0, +)
        
        let previousValue = portfolioCoins
            .map{(coin) -> Double in
                
                let currentValue = coin.currentHoldingsValue
                let percentChange = coin.priceChangePercentage24H ?? 0 / 100
                let previousValue = currentValue / (1 + percentChange)
                
                return previousValue
            }
            .reduce(0, +)
        
        let percentageChange = (portfolioValue - previousValue) / previousValue
        
        let portfolio = Statistics(title: "Portfolio Value", value: portfolioValue.asCurrencyWith2Decimal(),percentageChange: percentageChange)
        
        stats.append(contentsOf: [marketcap,volume,btcDominance,portfolio])
        return stats
    }
    
    private func mapAllCoinsToPortfolioCoins(allCoins: [Coin], portfolioEntities: [PortfolioEntity]) -> [Coin] {
        allCoins
            .compactMap { coin -> Coin? in
                guard let entity = portfolioEntities.first(where: { $0.coinID == coin.id}) else { return nil }
                return coin.updateHolding(amount: entity.amount)
            }
        
    }
}
