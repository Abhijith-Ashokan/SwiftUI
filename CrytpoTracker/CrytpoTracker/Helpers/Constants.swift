//
//  Constants.swift
//  CrytpoTracker
//
//  Created by Abhjith on 07/03/24.
//

import Foundation

struct URLConstants {
    
    static let coinGeckoMarketURL: String = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=inr&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h&x_cg_demo_api_key=CG-HSYzKnVc5EAD9Adj4LLpzr5f"
    
    static let globalMarketDataURL: String =
        "https://api.coingecko.com/api/v3/global"
    
    static func coinDetailURL(for coinID: String) -> String {
        return "https://api.coingecko.com/api/v3/coins/\(coinID)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false"
    }
}
