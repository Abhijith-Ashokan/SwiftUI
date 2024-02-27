//
//  TransactionsListViewModel.swift
//  ExpenseTracker
//
//  Created by Aoole on 22/02/24.
//

import Foundation
import Combine

final class TransactionsListViewModel: ObservableObject {
    
    @Published var transactions: [Transaction] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        getTranscation()
    }
    
    func getTranscation () {
        
        guard let url = URL(string: Urls.transactionsURL) else {
            print("Error: Invalid URL")
            return }
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response) in
                guard let httpResponse = response as? HTTPURLResponse,httpResponse.statusCode == 200 else {
                    dump(response)
                    throw(URLError(.badServerResponse))
                }
                return data
            }
            .decode(type: [Transaction].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching transactions",error.localizedDescription)
                case .finished:
                    print("Finished fetching transactions")
                }
            } receiveValue: { [weak self]result in
                self?.transactions = result
                dump(self?.transactions)
            }
            .store(in: &cancellables)

    }
}
