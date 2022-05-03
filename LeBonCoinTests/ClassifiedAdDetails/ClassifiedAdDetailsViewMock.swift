//
//  ClassifiedAdDetailsViewMock.swift
//  LeBonCoinTests
//
//  Created by Adrien Grondin on 03/05/2022.
//

import Foundation
@testable import LeBonCoin

class ClassifiedAdDetailsViewMock: ClassifiedAdDetailsViewProtocol {
    var classifiedAd: ClassifiedAd?
    var categoryName: String = ""

    func setClassifiedAd(_ classifiedAd: ClassifiedAd, categoryName: String) {
        self.classifiedAd = classifiedAd
        self.categoryName = categoryName
    }
}
