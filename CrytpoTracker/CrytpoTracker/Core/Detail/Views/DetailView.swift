//
//  DetailView.swift
//  CrytpoTracker
//
//  Created by Abhijith on 22/03/24.
//

import SwiftUI

struct DetailLoadingView: View {
    
    @Binding var coin: Coin?
    
    var body: some View {
        ZStack {
            if let coin = coin {
                DetailView(coin: coin)
            }
        }
    }
}

struct DetailView: View {
    
    @StateObject private var vm: DetailViewModel
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    private var spacing: CGFloat = 30
    
    var coin: Coin
    
    init(coin: Coin) {
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
        self.coin = coin
        print("Initialising DetailView for : \(coin.name)")

    }
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("") //TODO: placeholder for graph
                    .frame(height: 150)
                
                overviewTitle
                Divider()
                overviewGrid
                
                additionalTitle
                Divider()
                additionalGrid
              
            }
            .padding()
        }
        .navigationTitle(vm.coin.name)
    }
}

#Preview {
    NavigationStack {
        DetailView(coin: DeveloperPreview.instance.coin)
    }
}

extension DetailView {
    
    private var overviewTitle: some View {
        Text("Overview")
            .font(.title)
            .bold()
            .foregroundStyle(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var additionalTitle: some View {
        Text("Additional Details")
            .font(.title)
            .bold()
            .foregroundStyle(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var overviewGrid: some View {
        LazyVGrid(columns: columns,
                  alignment: .leading,
                  spacing: spacing,
                  content: {
            ForEach(vm.overviewStatistics) { stat in
                StatisticsView(stat: stat)
            }
        })
    }
    
    private var additionalGrid: some View {
        LazyVGrid(columns: columns,
                  alignment: .leading,
                  spacing: spacing,
                  content: {
            ForEach(vm.additionalStatistics) { stat in
                StatisticsView(stat: stat)
            }
        })
    }
}
