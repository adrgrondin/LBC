//
//  ClassifiedAdContentConfiguration.swift
//  LeBonCoin
//
//  Created by Adrien Grondin on 28/04/2022.
//

import Foundation
import UIKit

struct ClassifiedAdContentConfiguration: UIContentConfiguration, Hashable {
    var title: String? = nil
    var category: String? = nil
    var price: Double? = nil
    var isUrgent: Bool? = nil
    var image: UIImage? = nil
    
    func makeContentView() -> UIView & UIContentView {
        return ClassifiedAdContentView(configuration: self)
    }
    
    func updated(for state: UIConfigurationState) -> Self {
        return self
    }
}
