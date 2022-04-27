//
//  ClassifiedAdsCoordinator.swift
//  LeBonCoin
//
//  Created by Adrien Grondin on 27/04/2022.
//

import UIKit

final class ClassifiedAdsCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?

    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let presenter = ClassifiedAdsPresenter()
        presenter.coordinator = self
        
        let viewController = ClassifiedAdsViewController(presenter: presenter)
        navigationController.pushViewController(viewController, animated: false)
    }
}
