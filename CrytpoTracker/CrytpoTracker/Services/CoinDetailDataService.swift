//
//  CoinDetailService.swift
//  CrytpoTracker
//
//  Created by Abhijith on 27/03/24.
//

import Foundation
import Combine

class CoinDetailDataService {
    
    @Published var coinDetails: CoinDetail? = nil
    
    var coinDetailSubscription: AnyCancellable?
    let coin: Coin
    
    init(coin: Coin) {
        self.coin = coin
        getCoinDetail (coin: coin)
    }
    
    func getCoinDetail(coin: Coin) {
        guard let url = URL(string: URLConstants.coinDetailURL(for: coin.id)) else { return }
        
        coinDetailSubscription = NetworkingManager.download(url: url)
            .decode(type: CoinDetail.self, decoder: JSONDecoder())
            .sink(receiveCompletion:  NetworkingManager.handleCompletion, receiveValue: {  returnedCoinDetails in
                self.coinDetails = returnedCoinDetails
                self.coinDetailSubscription?.cancel()
            })
    }
}

