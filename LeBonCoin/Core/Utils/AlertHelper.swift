//
//  AlertHelper.swift
//  LeBonCoin
//
//  Created by Adrien Grondin on 03/05/2022.
//

import UIKit

public struct AlertHelper {
    public static func showError(_ title: String? = "Il y a un problème !",
                                 message: String,
                                 cancelAction: UIAlertAction? = nil) -> UIAlertController {

        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)

        let alertCancelAction = cancelAction ?? UIAlertAction(title: "OK",
                                                              style: .default,
                                                              handler: nil)

        alertController.addAction(alertCancelAction)

        return alertController
    }
}
