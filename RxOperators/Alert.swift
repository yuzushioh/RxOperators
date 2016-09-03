//
//  Alert.swift
//  RxOperators
//
//  Created by 福田涼介 on 9/3/16.
//  Copyright © 2016 yuzushio. All rights reserved.
//

import UIKit

final class Alert {
    static func showAlert(title: String?, message: String? = nil, completionHandler: (Void -> Void)? = nil, baseViewController: UIViewController?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alertController.addAction(
            UIAlertAction(
                title: "OK",
                style: .Default,
                handler: { action in
                    completionHandler?()
            })
        )
        
        baseViewController?.presentViewController(alertController, animated: true, completion: nil)
    }
}