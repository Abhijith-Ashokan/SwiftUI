//
//  PortfolioDataService.swift
//  CrytpoTracker
//
//  Created by Abhijith on 20/03/24.
//

import UIKit
import CoreData

class PortfolioDataService {
    
    private let container: NSPersistentContainer
    private let containerName = "PortfolioContainer"
    private let entityName = "PortfolioEntity"
    
    @Published var savedEntities: [PortfolioEntity] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores {_, error in
            if let error = error {
                print("Error loading CoreData! \(error.localizedDescription)")
            }
        }
        self.getPortfolio()
    }
    
    //MARK: PUBLIC
    
    func upadtePortfolio(coin: Coin, amount: Double) {
        
        //check if coin already in portfolio
        if let entity = savedEntities.first(where: { $0.coinID == coin.id }) {
            if amount > 0 {
                update(entity: entity, amount: amount)
            } else {
                delete(enity: entity)
            }
        } else {
            add(coin: coin, amount: amount)
        }
    }
    
    //MARK: PRIVATE
    
    private func getPortfolio() {
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        do {
         savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching Portfolio Entities")
        }
    }
    
    private func add(coin: Coin, amount: Double) {
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
        applyChanges()
    }
    
    private func update(entity:PortfolioEntity, amount: Double) {
        entity.amount = amount
        applyChanges()
    }
    
    private func delete(enity: PortfolioEntity) {
        container.viewContext.delete(enity)
        applyChanges()
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving to Core Data!\(error)")
        }
    }
    
    private func applyChanges() {
        save()
        getPortfolio()
    }
    
}
