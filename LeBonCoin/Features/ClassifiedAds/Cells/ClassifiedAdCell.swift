//
//  ClassifiedAdCell.swift
//  LeBonCoin
//
//  Created by Adrien Grondin on 28/04/2022.
//

import UIKit

final class ClassifiedAdCell: UICollectionViewCell {
    var title: String? {
        didSet {
            setNeedsUpdateConfiguration()
        }
    }

    var price: Double? {
        didSet {
            setNeedsUpdateConfiguration()
        }
    }

    var category: String? {
        didSet {
            setNeedsUpdateConfiguration()
        }
    }

    var isUrgent: Bool? {
        didSet {
            setNeedsUpdateConfiguration()
        }
    }

    private var loadedImage: UIImage? {
        didSet {
            setNeedsUpdateConfiguration()
        }
    }

    var imageUrl: String? {
        didSet {
            if let imageUrl = imageUrl,
               let url = URL(string: imageUrl) {
                imageTask = imageService.image(for: url) { [weak self] image in
                    self?.loadedImage = image
                }
            } else {
                self.loadedImage = UIImage(named: "placeholder")
            }
        }
    }

    private lazy var imageService = ReusableCellImageService()

    private var imageTask: Cancellable?

    override func prepareForReuse() {
        super.prepareForReuse()

        loadedImage = nil

        imageTask?.cancel()
    }

    override func updateConfiguration(using state: UICellConfigurationState) {
        var content = ClassifiedAdContentConfiguration().updated(for: state)
        content.title = title
        content.price = price
        content.category = category
        content.isUrgent = isUrgent
        content.image = loadedImage

        contentConfiguration = content
    }
}
