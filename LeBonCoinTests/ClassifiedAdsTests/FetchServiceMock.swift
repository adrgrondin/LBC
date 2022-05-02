//
//  FetchServiceMock.swift
//  LeBonCoinTests
//
//  Created by Adrien Grondin on 02/05/2022.
//

import Foundation
@testable import LeBonCoin

struct FetchServiceMock { }

extension FetchServiceMock: ListingFetcher {
    func fetchListing() async throws -> Listing {
        guard let url = Bundle.main.url(forResource: "Listing", withExtension: "json"),
              let data = try? Data(contentsOf: url) else { return [] }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        return try decoder.decode(Listing.self, from: data)
    }
}

extension FetchServiceMock: CategoriesFetcher {
    func fetchCategories() async throws -> Categories {
        guard let url = Bundle.main.url(forResource: "Categories", withExtension: "json"),
              let data = try? Data(contentsOf: url) else { return [] }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        return try decoder.decode(Categories.self, from: data)
    }
}
