//
//  ClassifiedAdsPresenter.swift
//  LeBonCoin
//
//  Created by Adrien Grondin on 27/04/2022.
//

import Foundation

protocol ClassifiedAdsPresenterProtocol: AnyObject {
    func attach(view: ClassifiedAdsViewProtocol)
    func didSelectCategory(_ category: Category)
    func resetCategory()
}

final class ClassifiedAdsPresenter {
    
    // MARK: Variables
    
    weak private var view: ClassifiedAdsViewProtocol? {
        didSet {
            Task {
                await fetchCategories()
                await fetchListing()
                await updateDataSource()
            }
        }
    }
    
    weak var coordinator: ClassifiedAdsCoordinator?

    private let fetchService: ListingFetcher & CategoriesFetcher
    
    private var listing: Listing = []

    private var categories: Categories = []
    

    // MARK: Initialization
    
    init(fetchService: ListingFetcher & CategoriesFetcher) {
        self.fetchService = fetchService
    }
    
    // MARK: Functions
    
    private func fetchListing() async {
        do {
            listing = try await fetchService.fetchListing()
        } catch {
            // TODO: Handle error
            print(String(describing: error))
        }
    }

    private func fetchCategories() async {
        do {
            categories = try await fetchService.fetchCategories()
        } catch {
            // TODO: Handle error
            print(String(describing: error))
        }
    }
    
    @MainActor
    private func updateDataSource() {
        listing.sort(by: { $0.creationDate > $1.creationDate })
        listing.sort(by: { $0.isUrgent && !$1.isUrgent })

        view?.updateDataSource(with: listing, categories: categories, animatingDifferences: false)
    }
}

// MARK: - ClassifiedAdsPresenterProtocol

extension ClassifiedAdsPresenter: ClassifiedAdsPresenterProtocol {
    func attach(view: ClassifiedAdsViewProtocol) {
        self.view = view
    }

    func didSelectCategory(_ category: Category) {
        let filteredListing = listing.filter({ $0.categoryID == category.id })
        view?.updateDataSource(with: filteredListing, categories: categories, animatingDifferences: true)
    }

    func resetCategory() {
        view?.updateDataSource(with: listing, categories: categories, animatingDifferences: true)
    }
}
