//
//  MarketDataService.swift
//  CrytpoTracker
//
//  Created by Abhijith on 12/03/24.
//

import Foundation
import Combine

class MarketDataService {
    
    @Published var marketData: MarketData? = nil
    var marketDataSubscription: AnyCancellable?
    
    init() {
        getData()
    }
    
    func getData() {
        guard let url = URL(string: URLConstants.globalMarketDataURL) else { return }
        
        marketDataSubscription = NetworkingManager.download(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink(receiveCompletion:  NetworkingManager.handleCompletion, receiveValue: { returnedGlobalData in
                self.marketData = returnedGlobalData.data
                self.marketDataSubscription?.cancel()
            })
    }
}
