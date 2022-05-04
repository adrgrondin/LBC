//
//  ClassifiedAdsViewController.swift
//  LeBonCoin
//
//  Created by Adrien Grondin on 27/04/2022.
//

import UIKit

protocol ClassifiedAdsViewProtocol: AnyObject {
    func updateDataSource(with listing: Listing, categories: Categories, animatingDifferences: Bool)
    func showError(message: String)
    func showLoading()
    func hideLoading()
}

final class ClassifiedAdsViewController: UIViewController {

    private enum Section {
        case main
    }

    // MARK: Variables

    private var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()

    private var collectionView: UICollectionView! = nil

    private var presenter: ClassifiedAdsPresenterProtocol!

    private var dataSource: UICollectionViewDiffableDataSource<Section, ClassifiedAd>! = nil

    private var listing: Listing = []

    private var categories: Categories = []

    // MARK: Initialization

    init(presenter: ClassifiedAdsPresenter) {
        self.presenter = presenter

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: LifeCycle

    override func loadView() {
        super.loadView()

        setupActivityIndicatorView()
        setupCollectionView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Annonces"
        view.backgroundColor = Colors.white

        configureDataSource()

        presenter.attach(view: self)
    }

    // MARK: Functions

    private func setupActivityIndicatorView() {
        view.addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCollectionViewLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = Colors.white
        collectionView.delegate = self

        view.addSubview(collectionView)
    }

    func createCollectionViewLayout() -> UICollectionViewLayout {
        let estimatedHeight = CGFloat(300)

        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(estimatedHeight))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(estimatedHeight))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        section.interGroupSpacing = 10

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }

    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<ClassifiedAdCell, ClassifiedAd> { [weak self] (cell, indexPath, classifiedAd) in
            cell.title = classifiedAd.title
            cell.price = classifiedAd.price
            cell.imageUrl = classifiedAd.imagesURL.thumb
            cell.category = self?.getCategoryName(for: classifiedAd.categoryID)
            cell.isUrgent = classifiedAd.isUrgent
        }

        dataSource = UICollectionViewDiffableDataSource<Section, ClassifiedAd>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: ClassifiedAd) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }

        applySnapshot(animatingDifferences: false)
    }

    private func updateCategoriesMenu() {
        var actions: [UIAction] = []

        for category in categories {
            let action = UIAction(title: category.name, image: nil) { [weak self] _ in
                self?.presenter.didSelectCategory(category)
            }

            actions.append(action)
        }

        let clearAction = UIAction(title: "Réinitialiser",
                                   image: UIImage(systemName: "minus.circle"),
                                   attributes: .destructive,
                                   handler: { [weak self] _ in
            self?.presenter.resetCategory()
        })

        actions.append(clearAction)

        let menu = UIMenu(title: "Catégories", children: actions)

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), menu: menu)
    }

    private func applySnapshot(animatingDifferences: Bool) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, ClassifiedAd>()
        snapshot.appendSections([.main])
        snapshot.appendItems(listing)

        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }

    private func getCategoryName(for id: Int) -> String? {
        return categories.first(where: { $0.id == id })?.name
    }
}

// MARK: - ClassifiedAdsPresenterProtocol
extension ClassifiedAdsViewController: ClassifiedAdsViewProtocol {

    func updateDataSource(with listing: Listing, categories: Categories, animatingDifferences: Bool) {
        self.categories = categories
        self.listing = listing

        updateCategoriesMenu()
        applySnapshot(animatingDifferences: animatingDifferences)
    }

    func showError(message: String) {
        let alert = AlertHelper.showError(message: message)

        present(alert, animated: true)
    }

    func showLoading() {
        activityIndicator.startAnimating()
        collectionView.isHidden = true
        activityIndicator.isHidden = false
    }

    func hideLoading() {
        collectionView.isHidden = false
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }
}

// MARK: - UICollectionViewDelegate

extension ClassifiedAdsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let classifiedAd = dataSource.itemIdentifier(for: indexPath),
              let categoryName = getCategoryName(for: classifiedAd.categoryID) else {
            return
        }

        presenter.showDetails(with: classifiedAd, categoryName: categoryName)
    }
}

