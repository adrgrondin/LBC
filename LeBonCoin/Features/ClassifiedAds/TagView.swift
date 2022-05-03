//
//  TagView.swift
//  LeBonCoin
//
//  Created by Adrien Grondin on 30/04/2022.
//

import UIKit

final class TagView: UIView {

    var text: String? {
        didSet {
            label.text = text
        }
    }

    var color: UIColor? {
        didSet {
            backgroundColor = color
        }
    }

    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.white

        return label
    }()

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setupInternalViews()
    }

    init() {
        super.init(frame: .zero)

        setupInternalViews()
    }

    func setupInternalViews() {
        layer.cornerRadius = 8

        addSubview(label)

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 0),
            label.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 0),
            label.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: -0),
            label.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor, constant: 0)
        ])
    }
}
