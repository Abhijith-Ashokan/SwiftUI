//
//  OrderView.swift
//  Appetizers
//
//  Created by Abhijith on 27/02/24.
//

import SwiftUI

struct OrderView: View {
    
    @EnvironmentObject var order: Order
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    List {
                        ForEach(order.items) { order in
                            AppetizerListCell(appetizer: order)
                        }
                        .onDelete(perform: order.deleteItems)
                    }
                    .listStyle(.plain)
                    
                    Button {
                        print("Order placed successfully")
                    } label: {
                        Text("₹\(order.totalPrice, specifier: "%.2f") - Place Order")
                    }
                    .modifier(StandardButtonStyle())
                }
                .padding(.bottom, 25)
                .navigationTitle("🧾 Order")
                if order.items.isEmpty {
                    EmptyState(imageName: "empty-order", message: "Add items to show them here")
                }
            }
        }
    }
}

#Preview {
    OrderView()
}
