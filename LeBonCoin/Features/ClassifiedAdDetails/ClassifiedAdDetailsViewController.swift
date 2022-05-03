//
//  ClassifiedAdDetailsViewController.swift
//  LeBonCoin
//
//  Created by Adrien Grondin on 02/05/2022.
//

import UIKit

protocol ClassifiedAdDetailsViewProtocol: AnyObject {
    func setClassifiedAd(_ classifiedAd: ClassifiedAd, categoryName: String)
}

class ClassifiedAdDetailsViewController: UIViewController {

    // MARK: Variables

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

        return imageView
    }()

    private let closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "closeButton"), for: .normal)

        return button
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = .boldSystemFont(ofSize: 24)

        return label
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 18)

        return label
    }()

    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)

        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.grayLight
        label.font = .systemFont(ofSize: 12)

        return label
    }()

    private let descriptionTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 18)
        label.text = "Description"

        return label
    }()

    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .systemFont(ofSize: 15)
        textView.backgroundColor = Colors.graySuperLight
        textView.layer.cornerRadius = 5
        textView.isEditable = false

        return textView
    }()

    private let siretLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 13)

        return label
    }()

    private let isUrgentTag: TagView = {
        let tagView = TagView()
        tagView.text = "Urgent"
        tagView.color = Colors.orange
        tagView.translatesAutoresizingMaskIntoConstraints = false

        return tagView
    }()

    private var presenter: ClassifiedAdDetailsPresenter!

    // MARK: Initialization

    init(presenter: ClassifiedAdDetailsPresenter) {
        self.presenter = presenter

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: LifeCycle

    override func loadView() {
        super.loadView()

        setupInternalViews()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Colors.white

        closeButton.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)

        presenter.attach(view: self)
    }

    // MARK: Functions

    private func setupInternalViews() {
        view.addSubview(imageView)
        view.addSubview(closeButton)
        view.addSubview(isUrgentTag)
        view.addSubview(titleLabel)
        view.addSubview(priceLabel)
        view.addSubview(categoryLabel)
        view.addSubview(dateLabel)
        view.addSubview(descriptionTitleLabel)
        view.addSubview(descriptionTextView)
        view.addSubview(siretLabel)

        let safeArea = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0),
            imageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 0),
            imageView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 0),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4)
        ])

        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 8),
            closeButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -8),
            closeButton.widthAnchor.constraint(equalToConstant: 40),
            closeButton.heightAnchor.constraint(equalToConstant: 40)
        ])

        NSLayoutConstraint.activate([
            isUrgentTag.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -16),
            isUrgentTag.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16)
        ])

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16)
        ])

        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            priceLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            priceLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16)
        ])

        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 5),
            categoryLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            categoryLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16)
        ])

        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 5),
            dateLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            dateLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16)
        ])

        NSLayoutConstraint.activate([
            descriptionTitleLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 15),
            descriptionTitleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            descriptionTitleLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16)
        ])

        NSLayoutConstraint.activate([
            descriptionTextView.topAnchor.constraint(equalTo: descriptionTitleLabel.bottomAnchor, constant: 3),
            descriptionTextView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            descriptionTextView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16)
        ])

        NSLayoutConstraint.activate([
            siretLabel.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 5),
            siretLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            siretLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            siretLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -8)
        ])
    }

    // MARK: Actions

    @objc private func didTapCloseButton() {
        presenter.didTapCloseButton()
    }
}

// MARK: - ClassifiedAdDetailsViewProtocol

extension ClassifiedAdDetailsViewController: ClassifiedAdDetailsViewProtocol {
    func setClassifiedAd(_ classifiedAd: ClassifiedAd, categoryName: String) {
        if let url = URL(string: classifiedAd.imagesURL.thumb ?? "") {
            imageView.load(url: url, placeholder: UIImage(named: "placeholder"))
        }

        titleLabel.text = classifiedAd.title
        priceLabel.text = classifiedAd.price.formattedCurrency
        categoryLabel.text = categoryName
        descriptionTextView.text = classifiedAd.listingDescription
        isUrgentTag.isHidden = !classifiedAd.isUrgent
        dateLabel.text = classifiedAd.creationDate.formattedDate

        if let siret = classifiedAd.siret {
            siretLabel.text = "SIRET: \(siret)"
        }
    }
}
