//
//  OrderView.swift
//  Appetizers
//
//  Created by Abhijith on 27/02/24.
//

import SwiftUI

struct OrderView: View {
    
    @State private var orderItems = MockData.sampleOrders
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(orderItems) { order in
                        AppetizerListCell(appetizer: order)
                    }
                    .onDelete(perform: deleteItems)
                }
                .listStyle(.plain)
                
                Button {
                    print("Order placed successfully")
                } label: {
                    APButton(title: "₹99.99 - Place ORder")
                }
            }
            .padding(.bottom, 25)
            .navigationTitle("🧾 Order")
        }
        
    }
    
    func deleteItems(at offset: IndexSet){
        orderItems.remove(atOffsets: offset)
    }
}

#Preview {
    OrderView()
}
