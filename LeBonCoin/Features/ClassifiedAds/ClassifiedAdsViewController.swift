//
//  ClassifiedAdsViewController.swift
//  LeBonCoin
//
//  Created by Adrien Grondin on 27/04/2022.
//

import UIKit

protocol ClassifiedAdsViewProtocol: AnyObject { }

final class ClassifiedAdsViewController: UIViewController {

    // MARK: Variables

    private var presenter: ClassifiedAdsPresenterProtocol!

    // MARK: Initialization

    init(presenter: ClassifiedAdsPresenter) {
        self.presenter = presenter

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.attach(view: self)
    }
}

// MARK: - ClassifiedAdsPresenterProtocol

extension ClassifiedAdsViewController: ClassifiedAdsViewProtocol { }
