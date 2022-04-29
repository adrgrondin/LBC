//
//  ClassifiedAdContentView.swift
//  LeBonCoin
//
//  Created by Adrien Grondin on 28/04/2022.
//

import UIKit

final class ClassifiedAdContentView: UIView, UIContentView {
    var configuration: UIContentConfiguration {
        get { appliedConfiguration }
        set {
            guard let newConfig = newValue as? ClassifiedAdContentConfiguration else { return }
            apply(configuration: newConfig)
        }
    }

    private var appliedConfiguration: ClassifiedAdContentConfiguration!

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true

        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let isUrgentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    init(configuration: ClassifiedAdContentConfiguration) {
        super.init(frame: .zero)

        setupInternalViews()
        apply(configuration: configuration)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupInternalViews() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(priceLabel)
        addSubview(categoryLabel)

        // TODO: Add isUrgent label

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 5),
            imageView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 5),
            imageView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: -5)
        ])

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 3),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -5)
        ])

        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 3),
            priceLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -5)
        ])

        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 3),
            categoryLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            categoryLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -5),
            categoryLabel.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor, constant: -5)
        ])
    }

    private func apply(configuration: ClassifiedAdContentConfiguration) {
        guard appliedConfiguration != configuration else { return }
        appliedConfiguration = configuration

        if let imageUrl = configuration.imageUrl,
           let url = URL(string: imageUrl) {
            imageView.load(url: url, placeholder: UIImage(named: "placeholder"))
        }

        categoryLabel.text = configuration.category

        // TODO: Do correct currency formatting

        priceLabel.text = "\(configuration.price ?? 0) €"
        titleLabel.text = configuration.title
    }
}
