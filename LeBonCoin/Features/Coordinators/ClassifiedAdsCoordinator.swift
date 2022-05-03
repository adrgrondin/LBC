//
//  ClassifiedAdsCoordinator.swift
//  LeBonCoin
//
//  Created by Adrien Grondin on 27/04/2022.
//

import UIKit

protocol ClassifiedAdsCoordinatorShowDetails: AnyObject {
    func showDetails(with classifiedAd: ClassifiedAd, categoryName: String)
}

final class ClassifiedAdsCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?

    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let presenter = ClassifiedAdsPresenter(fetchService: FetchService(apiManager: APIManager()))
        presenter.coordinator = self

        navigationController.navigationBar.prefersLargeTitles = true

        let viewController = ClassifiedAdsViewController(presenter: presenter)
        navigationController.pushViewController(viewController, animated: false)
    }
}

// MARK: - ClassifiedAdsShowDetailsCoordinator

extension ClassifiedAdsCoordinator: ClassifiedAdsCoordinatorShowDetails {
    func showDetails(with classifiedAd: ClassifiedAd, categoryName: String) {
        let presenter = ClassifiedAdDetailsPresenter(classifiedAd: classifiedAd, categoryName: categoryName)
        presenter.coordinator = self

        let viewController = ClassifiedAdDetailsViewController(presenter: presenter)
        navigationController.present(viewController, animated: true)
    }
}

// MARK: - DismissableCoordinator

extension ClassifiedAdsCoordinator: DismissableCoordinator {
    func dismiss() {
        navigationController.dismiss(animated: true)
    }
}
