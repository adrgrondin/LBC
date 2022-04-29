//
//  FetchService.swift
//  LeBonCoin
//
//  Created by Adrien Grondin on 28/04/2022.
//

import Foundation

protocol ListingFetcher {
    func fetchListing() async throws -> Listing
}

protocol CategoriesFetcher {
    func fetchCategories() async throws -> Categories
}

struct FetchService {
    private let apiManager: APIManagerProtocol
    
    init(apiManager: APIManagerProtocol) {
        self.apiManager = apiManager
    }
}

// MARK: - ListingFetcher

extension FetchService: ListingFetcher {
    func fetchListing() async throws -> Listing {
        let request = ListingRequest.getListing
        
        let listing: Listing = try await apiManager.initRequest(with: request)
        
        return listing
    }
}

// MARK: - CategoriesFetcher

extension FetchService: CategoriesFetcher {
    func fetchCategories() async throws -> Categories {
        let request = CategoriesRequest.getCategories

        let categories: Categories = try await apiManager.initRequest(with: request)

        return categories
    }
}
