//
//  ClassifiedAdDetailsPresenter.swift
//  LeBonCoin
//
//  Created by Adrien Grondin on 02/05/2022.
//

import Foundation

protocol ClassifiedAdDetailsPresenterProtocol: AnyObject {
    func attach(view: ClassifiedAdDetailsViewProtocol)
    func didTapCloseButton()
}

final class ClassifiedAdDetailsPresenter {

    // MARK: Variables

    weak private(set) var view: ClassifiedAdDetailsViewProtocol? {
        didSet {
            setupView()
        }
    }

    weak var coordinator: ClassifiedAdsCoordinator?

    private let classifiedAd: ClassifiedAd
    private let categoryName: String

    // MARK: Initialization

    init(classifiedAd: ClassifiedAd, categoryName: String) {
        self.classifiedAd = classifiedAd
        self.categoryName = categoryName
    }

    // MARK: Functions

    func setupView() {
        view?.setClassifiedAd(classifiedAd, categoryName: categoryName)
    }
}

// MARK: - ClassifiedAdDetailsPresenterProtocol

extension ClassifiedAdDetailsPresenter: ClassifiedAdDetailsPresenterProtocol {
    func didTapCloseButton() {
        coordinator?.dismiss()
    }
    
    func attach(view: ClassifiedAdDetailsViewProtocol) {
        self.view = view
    }
}
