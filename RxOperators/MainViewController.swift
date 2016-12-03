//
//  MainViewController.swift
//  RxOperators
//
//  Created by 福田涼介 on 9/3/16.
//  Copyright © 2016 yuzushio. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    fileprivate func pushToViewController(_ viewController: UIViewController, animated: Bool) {
        navigationController?.pushViewController(viewController, animated: animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let identifier = segue.identifier else { return }
        switch identifier {
        case "Single":
            guard let destinationViewController = segue.destination as? SimpleValidationViewController else { return }
            destinationViewController.validationType = .single
        case "Double":
            guard let destinationViewController = segue.destination as? SimpleValidationViewController else { return }
            destinationViewController.validationType = .double
        default:
            break
        }
    }
}
