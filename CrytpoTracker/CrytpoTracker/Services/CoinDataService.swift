//
//  CoinDataService.swift
//  CrytpoTracker
//
//  Created by Abhijith on 07/03/24.
//

import Foundation
import Combine

class CoinDataService {
    
    @Published var allCoins: [Coin] = []
    var coinSubscription: AnyCancellable?
    
    init() {
        getCoins ()
    }
    
    private func getCoins() {
        guard let url = URL(string: URLConstants.coinGeckoMarketURL) else { return }
        
        coinSubscription = NetworkingManager.download(url: url)
            .decode(type: [Coin].self, decoder: JSONDecoder())
            .sink(receiveCompletion:  NetworkingManager.handleCompletion, receiveValue: { returnedCoins in
                self.allCoins = returnedCoins
                self.coinSubscription?.cancel()
            })
    }
}
