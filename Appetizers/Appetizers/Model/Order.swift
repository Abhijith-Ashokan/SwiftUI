//
//  Order.swift
//  Appetizers
//
//  Created by Abhijith on 01/03/24.
//

import SwiftUI

final class Order: ObservableObject {
    
    @Published var items: [Appetizer] = []
    
    var totalPrice: Double {
        items.reduce(0) { $0 + $1.price }
        }
    
    func addItemToOrder(_ appetizer: Appetizer) {
        items.append(appetizer)
    }
    
    func deleteItems(at offset: IndexSet) {
        items.remove(atOffsets: offset)
    }
}
