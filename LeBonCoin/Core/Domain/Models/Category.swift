//
//  Category.swift
//  LeBonCoin
//
//  Created by Adrien Grondin on 27/04/2022.
//

import Foundation

struct Category: Codable {
    let id: Int
    let name: String
}

typealias Categories = [Category]
