//
//  Listing.swift
//  LeBonCoin
//
//  Created by Adrien Grondin on 27/04/2022.
//

import Foundation

struct ClassifiedAd: Codable {
    let id, categoryID: Int
    let title, listingDescription: String
    let price: Int
    let imagesURL: ImagesURL
    let creationDate: Date
    let isUrgent: Bool
    let siret: String?

    enum CodingKeys: String, CodingKey {
        case id
        case categoryID = "category_id"
        case title
        case listingDescription = "description"
        case price
        case imagesURL = "images_url"
        case creationDate = "creation_date"
        case isUrgent = "is_urgent"
        case siret
    }
}

typealias Listing = [ClassifiedAd]
