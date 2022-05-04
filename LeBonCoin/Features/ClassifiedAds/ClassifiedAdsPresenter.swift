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
    func showDetails(with classifiedAd: ClassifiedAd, categoryName: String)
}

final class ClassifiedAdsPresenter {
    
    // MARK: Variables
    
    weak private(set) var view: ClassifiedAdsViewProtocol? {
        didSet {
            Task {
                await showLoading()
                await fetchCategories()
                await fetchListing()
                await updateDataSource()
                await hideLoading()
            }
        }
    }
    
    weak var coordinator: ClassifiedAdsCoordinatorShowDetails?

    private let fetchService: ListingFetcher & CategoriesFetcher
    
    private(set) var listing: Listing = []

    private(set) var categories: Categories = []
    

    // MARK: Initialization
    
    init(fetchService: ListingFetcher & CategoriesFetcher) {
        self.fetchService = fetchService
    }
    
    // MARK: Functions
    
    private func fetchListing() async {
        do {
            listing = try await fetchService.fetchListing()
        } catch {
            await showError(error)
        }
    }

    private func fetchCategories() async {
        do {
            categories = try await fetchService.fetchCategories()
        } catch {
            await showError(error)
        }
    }
    
    @MainActor
    private func updateDataSource() {
        listing.sort(by: { $0.creationDate > $1.creationDate })
        listing.sort(by: { $0.isUrgent && !$1.isUrgent })

        view?.updateDataSource(with: listing, categories: categories, animatingDifferences: false)
    }

    @MainActor
    private func showError(_ error: Error) {
        view?.showError(message: error.localizedDescription)
    }

    @MainActor
    private func showLoading() {
        view?.showLoading()
    }

    @MainActor
    private func hideLoading() {
        view?.hideLoading()
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

    func showDetails(with classifiedAd: ClassifiedAd, categoryName: String) {
        coordinator?.showDetails(with: classifiedAd, categoryName: categoryName)
    }
}
