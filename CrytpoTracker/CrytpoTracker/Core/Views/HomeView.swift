//
//  HomeView.swift
//  CrytpoTracker
//
//  Created by Abhijith on 04/03/24.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showPortfolio: Bool = false  //animate right
    @State private var showPortfolioView: Bool = false  //new sheet
    @EnvironmentObject private var homeVM: HomeViewModel
    
    var body: some View {
        ZStack {
            
            //MARK: Background layer
            Color.theme.background
                .ignoresSafeArea()
                .sheet(isPresented: $showPortfolioView, content: {
                    PortfolioView()
                })
            
            //MARK: Content layer
            VStack {
                homeHeader
                HomeStatisticsView(showPortFolio: $showPortfolio)
                SearchBarView(searchText: $homeVM.searchBarText)
                columnTitles
                if !showPortfolio {
                    allCoinsList
                } else {
                    portfolioCoinsList
                }
                Spacer(minLength: 0)
            }
        }
    }
}

#Preview {
    NavigationView {
        HomeView()
            .toolbar(.hidden)
    }
    .environmentObject(DeveloperPreview.instance.homeVM)
}

extension HomeView {
    private var homeHeader: some View {
        HStack {
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .animation(nil, value: UUID())
                .background(
                    CircleButtonAnimation(animate: $showPortfolio))
                .onTapGesture {
                    if showPortfolio {
                        showPortfolioView.toggle()
                    }
                }
            Spacer()
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundStyle(Color.theme.accent)
                .animation(nil, value: UUID())
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring) {
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
    
    private var allCoinsList: some View {
        List {
            ForEach(homeVM.allCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .transition(.move(edge: .leading))
        .listStyle(.plain)
        .refreshable {
            reloadData() 
        }
    }
    
    private func reloadData() {
        homeVM.reloadData()
    }
    
    private var portfolioCoinsList: some View {
        List {
            ForEach(homeVM.portfolioCoins ) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .transition(.move(edge: .trailing))
        .listStyle(.plain)
    }
    
    private var columnTitles: some View {
        HStack {
            HStack {
                Text("Coin")
                Image(systemName: "chevron.down")
                    .opacity(homeVM.sortOption == .rank || homeVM.sortOption == .rankReversed ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: homeVM.sortOption == .rank ? 0.0 : 180))
            }
            .onTapGesture {
                withAnimation {
                    homeVM.sortOption = homeVM.sortOption == .rank ? .rankReversed : .rank
                }
            }
            
            Spacer()
            if showPortfolio {
                HStack {
                    Text("Holdings")
                    Image(systemName: "chevron.down")
                        .opacity(homeVM.sortOption == .holdings || homeVM.sortOption == .holdgingsReversed ? 1.0 : 0.0)
                        .rotationEffect(Angle(degrees: homeVM.sortOption == .holdings ? 0.0 : 180))
                }
                .onTapGesture {
                    withAnimation {
                        homeVM.sortOption = homeVM.sortOption == .holdings ? .holdgingsReversed : .holdings
                    }
                }
            }
            HStack {
                Text("Price")
                    .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
                Image(systemName: "chevron.down")
                    .opacity(homeVM.sortOption == .price || homeVM.sortOption == .priceReversed ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: homeVM.sortOption == .price ? 0.0 : 180))
            }
            .onTapGesture {
                withAnimation {
                    homeVM.sortOption = homeVM.sortOption == .price ? .priceReversed : .price
                }
            }
        }
        .font(.caption)
        .foregroundStyle(Color.theme.secondaryText)
        .padding(.horizontal)
    }
}
