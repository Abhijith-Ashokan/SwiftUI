//
//  Double.swift
//  CrytpoTracker
//
//  Created by Abhijith on 05/03/24.
//

import Foundation

extension Double {
    
    private var currencyFormatter2: NumberFormatter {
        
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = .current
        formatter.currencyCode = "inr"
        formatter.currencySymbol = "₹"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    func asCurrencyWith2Decimal() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter6.string(from: number) ?? "₹ 0.00"
    }
    
    private var currencyFormatter6: NumberFormatter {
        
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = .current
        formatter.currencyCode = "inr"
        formatter.currencySymbol = "₹"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    func asCurrencyWith6Decimal() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter6.string(from: number) ?? "₹ 0.00"
    }
    
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }
    
    func asPercentString() -> String {
        return asNumberString() + " %"
    }
}
                        
