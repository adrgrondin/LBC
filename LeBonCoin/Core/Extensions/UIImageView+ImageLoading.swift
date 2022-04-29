//
//  UIImageView+ImageLoading.swift
//  LeBonCoin
//
//  Created by Adrien Grondin on 29/04/2022.
//

import UIKit

extension UIImageView {
    func load(url: URL, placeholder: UIImage? = nil) {
        image = nil

        let urlrequest = URLRequest(url: url)

        Task {
            let (data, _) = try await URLSession.shared.data(for: urlrequest)

            image = UIImage(data: data) ?? placeholder
        }
    }
}
