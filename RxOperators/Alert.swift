//
//  Alert.swift
//  RxOperators
//
//  Created by 福田涼介 on 9/3/16.
//  Copyright © 2016 yuzushio. All rights reserved.
//

import UIKit

final class Alert {
    static func showAlert(_ title: String?, message: String? = nil, completionHandler: ((Void) -> Void)? = nil, baseViewController: UIViewController?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(
            UIAlertAction(
                title: "OK",
                style: .default,
                handler: { action in
                    completionHandler?()
            })
        )
        
        baseViewController?.present(alertController, animated: true, completion: nil)
    }
}
