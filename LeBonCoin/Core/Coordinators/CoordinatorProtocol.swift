//
//  CoordinatorProtocol.swift
//  LeBonCoin
//
//  Created by Adrien Grondin on 27/04/2022.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
