//
//  ClassifiedAdCell.swift
//  LeBonCoin
//
//  Created by Adrien Grondin on 28/04/2022.
//

import UIKit

final class ClassifiedAdCell: UICollectionViewCell {
    var imageUrl: String? {
        didSet {
            setNeedsUpdateConfiguration()
        }
    }
    
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
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        var content = ClassifiedAdContentConfiguration().updated(for: state)
        content.imageUrl = imageUrl
        content.title = title
        content.price = price
        content.category = category
        content.isUrgent = isUrgent
        
        contentConfiguration = content
    }
}
