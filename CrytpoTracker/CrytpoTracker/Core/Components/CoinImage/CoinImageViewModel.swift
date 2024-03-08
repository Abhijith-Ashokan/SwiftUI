//
//  CoinImageViewModel.swift
//  CrytpoTracker
//
//  Created by Abhijith on 08/03/24.
//

import SwiftUI
import Combine

class CoinImageViewModel: ObservableObject {
    
    @Published var coinImage: UIImage? = nil
    @Published var isLoading: Bool = true
    
    private let coin: Coin
    private let imageService: CoinImageService
    private var cancellables = Set<AnyCancellable>()
    
    init(coin: Coin) {
        self.coin = coin
        self.imageService = CoinImageService(coin: coin)
        addSubscribers()
    }
    
    private func addSubscribers() {
        imageService.$image
            .sink { [weak self] (_) in
                self?.isLoading = false
            } receiveValue: { [weak self] image in
                self?.coinImage = image
            }
            .store(in: &cancellables)
    }
}
