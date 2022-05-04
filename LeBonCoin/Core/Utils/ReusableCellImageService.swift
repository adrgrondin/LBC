//
//  ReusableCellImageService.swift
//  LeBonCoin
//
//  Created by Adrien Grondin on 04/05/2022.
//

import UIKit

protocol Cancellable {
    func cancel()
}

extension URLSessionTask: Cancellable { }

final class ReusableCellImageService {
    func image(for url: URL, completion: @escaping (UIImage?) -> Void) -> Cancellable {
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, _ in
            var image: UIImage?

            defer {
                DispatchQueue.main.async {
                    completion(image)
                }
            }

            if let data = data {
                image = UIImage(data: data) ?? UIImage(named: "placeholder")
            }
        }

        dataTask.resume()

        return dataTask
    }
}
