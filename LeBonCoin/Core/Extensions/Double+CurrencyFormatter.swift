//
//  Double+CurrencyFormatter.swift
//  LeBonCoin
//
//  Created by Adrien Grondin on 01/05/2022.
//

import Foundation

extension Double {
    private static let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        formatter.currencyCode = "EUR"
        return formatter
    }()

    var formattedCurrency: String {
        let number = NSNumber(value: self)

        return Self.currencyFormatter.string(from: number)!
    }
}
