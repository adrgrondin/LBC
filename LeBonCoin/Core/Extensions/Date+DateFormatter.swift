//
//  Date+DateFormatter.swift
//  LeBonCoin
//
//  Created by Adrien Grondin on 03/05/2022.
//

import Foundation

extension Date {
    private static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none

        let fr_FR = Locale(identifier: "fr_FR")
        dateFormatter.locale = fr_FR

        return dateFormatter
    }()

    var formattedDate: String {
        Self.dateFormatter.string(from: self)
    }
}
