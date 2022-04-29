//
//  ClassifiedAdsViewController.swift
//  LeBonCoin
//
//  Created by Adrien Grondin on 27/04/2022.
//

import UIKit

protocol ClassifiedAdsViewProtocol: AnyObject {
    func updateDataSource(with listing: Listing, categories: Categories, animatingDifferences: Bool)
}

final class ClassifiedAdsViewController: UIViewController {

    private enum Section {
        case main
    }

    // MARK: Variables

    private var presenter: ClassifiedAdsPresenterProtocol!

    private var collectionView: UICollectionView! = nil

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

    override func viewDidLoad() {
        super.viewDidLoad()

        configureCollectionView()
        configureDataSource()

        presenter.attach(view: self)
    }

    // MARK: Functions

    private func createCollectionViewLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(300))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        let spacing = CGFloat(10)
        group.interItemSpacing = .fixed(spacing)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }

    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCollectionViewLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
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

        applySnapshot(animatingDifferences: animatingDifferences)
    }
}
