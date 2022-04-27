//
//  ClassifiedAdsPresenter.swift
//  LeBonCoin
//
//  Created by Adrien Grondin on 27/04/2022.
//

import Foundation

protocol ClassifiedAdsPresenterProtocol: AnyObject {
    func attach(view: ClassifiedAdsViewProtocol)
}

final class ClassifiedAdsPresenter {

    // MARK: Variables

    weak private var view: ClassifiedAdsViewProtocol?
    weak var coordinator: ClassifiedAdsCoordinator?
}

// MARK: - ClassifiedAdsPresenterProtocol

extension ClassifiedAdsPresenter: ClassifiedAdsPresenterProtocol {
    func attach(view: ClassifiedAdsViewProtocol) {
        self.view = view
    }
}
