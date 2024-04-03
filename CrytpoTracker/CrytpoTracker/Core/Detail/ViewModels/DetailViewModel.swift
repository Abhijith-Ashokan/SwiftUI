//
//  DetailViewModel.swift
//  CrytpoTracker
//
//  Created by Abhijith on 27/03/24.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    
    @Published var overviewStatistics: [Statistics] = []
    @Published var additionalStatistics: [Statistics] = []
    
    @Published var coin: Coin
    private let coinDetailService: CoinDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: Coin) {
        self.coin = coin
        coinDetailService = CoinDetailDataService(coin: coin)
        addSubscribers()
    }
    
    private func addSubscribers() {
        coinDetailService.$coinDetails
            .combineLatest($coin)
            .map(mapDetailToStatistics)
            .sink { [weak self] returnedArrays in
                self?.overviewStatistics = returnedArrays.overview
                self?.additionalStatistics = returnedArrays.additional
                
            }
            .store(in: &cancellables)
    }
    
    private func mapDetailToStatistics(coinDetail: CoinDetail?, coin: Coin) -> (overview: [Statistics], additional: [Statistics]) {
        
        //OverView:
        let price = coin.currentPrice.asCurrencyWith6Decimal()
        let pricePercentChange = coin.priceChangePercentage24H
        let priceStat = Statistics(title: "Current Price", value: price, percentageChange: pricePercentChange)
        
        let marketCap = "$" + (coin.marketCap?.formattedWithAbbreviations() ?? "")
        let marketCapPercentChange = coin.marketCapChangePercentage24H
        let marketCapPercentStat = Statistics(title: "Market Capital", value: marketCap, percentageChange: marketCapPercentChange)
        
        let rank = "\(coin.rank)"
        let rankStat = Statistics(title: "Rank", value: rank)
        
        let volume = "$" + (coin.totalVolume?.formattedWithAbbreviations() ?? "")
        let volumeStat = Statistics(title: "Volume", value: volume)
        
        let overViewArray = [priceStat, marketCapPercentStat, rankStat, volumeStat]
        
        //Additional:
        let high24H = coin.high24H?.asCurrencyWith6Decimal() ?? "n/a"
        let highStat = Statistics(title: "24H High", value: high24H)
        
        let low24H = coin.low24H?.asCurrencyWith6Decimal() ?? "n/a"
        let lowStat = Statistics(title: "24H Low", value: low24H)
        
        let priceChange = coin.priceChange24H?.asCurrencyWith6Decimal() ?? "n/a"
        let priceChangePercent = coin.priceChangePercentage24H
        let priceChangeStat = Statistics(title: "24H Price Change", value: priceChange, percentageChange: priceChangePercent)
        
        let marketCapChange = coin.marketCapChange24H?.formattedWithAbbreviations() ?? ""
        let marketCapChangePercent = coin.marketCapChangePercentage24H
        let marketCapStat = Statistics(title: "Market Cap Change", value: marketCapChange, percentageChange: marketCapChangePercent)
        
        let blockTime = coinDetail?.blockTimeInMinutes ?? 0
        let blockTimeString = blockTime == 0 ? "n/a" : "\(blockTime)"
        let blockTimeStat = Statistics(title: "Block Time", value: blockTimeString)
        
        let additionalArray = [highStat, lowStat, priceChangeStat, marketCapStat, blockTimeStat]
        return(overViewArray,additionalArray)
    }
}
