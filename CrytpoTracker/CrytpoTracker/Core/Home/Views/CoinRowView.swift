//
//  CoinRowView.swift
//  CrytpoTracker
//
//  Created by Abhijith on 05/03/24.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin : Coin
    let showHoldingsColumn: Bool
    
    var body: some View {
        
        HStack(spacing: 0) {
            
            leftColumnView
            Spacer()
            
            if showHoldingsColumn {
                middleColumnView
            }
            
            rightColumnView
        }
        .font(.subheadline)
        .background(Color.theme.background)
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CoinRowView(coin: dev.coin, showHoldingsColumn: true)
                .previewLayout(.sizeThatFits)
        }
    }
}

extension CoinRowView {
    
    private var leftColumnView: some View {
        HStack {
            Text("\(coin.rank)")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundStyle(Color.theme.secondaryText)
                .frame(minWidth: 30)
            CoinImageView(coin: coin)
                .frame(width: 30, height: 30)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading, 6)
                .foregroundStyle(Color.theme.accent)
        }
    }
    
    private var middleColumnView: some View {
            VStack(alignment: .trailing) {
                Text(coin.currentHoldingsValue.asCurrencyWith2Decimal())
                Text((coin.currentHoldings ?? 0).asNumberString())
            }
            .foregroundStyle(Color.theme.accent)
    }
    
    private var rightColumnView: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentPrice.asCurrencyWith6Decimal())
                .fontWeight(.bold)
                .foregroundStyle(Color.theme.accent)
            Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                .foregroundStyle(coin.priceChangePercentage24H ?? 0 >= 0 ? Color.themeGreen : Color.themeRed)
            
        }
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
    }
}
