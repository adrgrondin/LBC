//
//  ClassifiedAdsViewMock.swift
//  LeBonCoinTests
//
//  Created by Adrien Grondin on 02/05/2022.
//

import Foundation
@testable import LeBonCoin

class ClassifiedAdsViewMock: ClassifiedAdsViewProtocol {
    var updateDataSourceCalled = false
    var listing: Listing = []

    func updateDataSource(with listing: Listing, categories: Categories, animatingDifferences: Bool) {
        updateDataSourceCalled.toggle()
        self.listing = listing
    }

    func showError(message: String) { }
    func showLoading() {}
    func hideLoading() {}
}
