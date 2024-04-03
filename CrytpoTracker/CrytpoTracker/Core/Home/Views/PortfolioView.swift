//
//  PortfolioView.swift
//  CrytpoTracker
//
//  Created by Abhijith on 15/03/24.
//

import SwiftUI

struct PortfolioView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var vm: HomeViewModel
    @State private var selectedCoin: Coin? = nil
    @State private var quantityText: String = ""
    @State private var showCheckmark: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    SearchBarView(searchText: $vm.searchBarText)
                        .padding(.horizontal)
                    coinLogoList
                    if (selectedCoin != nil) {
                        portfolioInputSection
                    }
                }
                .navigationTitle("Edit Portfolio")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button (action: {
                            dismiss()
                        }, label: {
                            Image(systemName: "xmark")
                                .font(.headline)
                        })
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        trailingNavBarButtons
                    }
                }
            }
            .onChange(of: vm.searchBarText) { oldValue, newValue in
                if newValue == "" {
                    removeCoinSelection()
                }
            }
   
        }
    }
}

#Preview {
    PortfolioView()
        .environmentObject(DeveloperPreview.instance.homeVM)
}


extension PortfolioView {
    private var coinLogoList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                ForEach(vm.searchBarText.isEmpty ? vm.portfolioCoins : vm.allCoins) { coin  in
                    CoinLogoView(coin: coin)
                        .frame(width: 75, height: 120)
                        .padding(4)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedCoin?.id == coin.id ? Color.themeGreen : Color.clear, lineWidth: 1 )
                        )
                        .onTapGesture {
                            withAnimation(.easeOut) {
                                if selectedCoin?.id == coin.id {
                                    selectedCoin = nil
                                } else {
                                    updateSelectedCoin(coin: coin)
                                }
                            }
                        }
                }
            }
            .padding(.vertical, 4)
            .padding(.leading)
            Text("")
        }
    }
    
    private func updateSelectedCoin(coin: Coin) {
        selectedCoin = coin
        
        if let portfolioCoin = vm.portfolioCoins.first(where: { $0.id == coin.id}), let amount = portfolioCoin.currentHoldings {
            quantityText = "\(amount)"
        } else {
            quantityText = ""
        }
    }
    
    private var portfolioInputSection: some View {
        
        VStack(spacing: 15) {
            HStack {
                Text("Current price of \(selectedCoin?.symbol.uppercased() ?? ""): ")
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrencyWith6Decimal() ?? "")
            }
            Divider()
            HStack {
                Text("Amount Holding:")
                Spacer()
                TextField("Example: 1.4", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack {
                Text("Current Value:")
                Spacer()
                Text(getCurrentvalue().asCurrencyWith2Decimal())
            }
        }
        .animation(.none, value: UUID())
        .padding()
        .font(.headline)
    }
    
    private var trailingNavBarButtons: some View {
        HStack {
            Image(systemName: "checkmark")
                .opacity(showCheckmark ? 1 : 0)
            Button(action: { saveButtonPressed() }, label: {
                Text("Save".uppercased())
            })
            .opacity(
                (selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText) ? 1.0 : 0.0 )
            )
        }
        .font(.headline)
    }
    
    private func getCurrentvalue() -> Double {
        
        if let quantity = Double(quantityText) {
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    
    private func saveButtonPressed() {
        
        guard
            let coin = selectedCoin,
            let amount = Double(quantityText)
            else { return }
        
        //save logic
        
        vm.updatePorfolio(coin: coin, amount: amount)
        
        withAnimation(.easeIn) {
            showCheckmark = true
            removeCoinSelection()
        }
        UIApplication.shared.endEditing()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation {
                showCheckmark = false
            }
        }
    }
    
    private func removeCoinSelection() {
        selectedCoin = nil
        vm.searchBarText = ""
    }
    
}
