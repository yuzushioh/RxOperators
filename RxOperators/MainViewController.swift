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
    
    private func pushToViewController(viewController: UIViewController, animated: Bool) {
        navigationController?.pushViewController(viewController, animated: animated)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        
        guard let identifier = segue.identifier else { return }
        switch identifier {
        case "Single":
            guard let destinationViewController = segue.destinationViewController as? SimpleValidationViewController else { return }
            destinationViewController.validationType = .Single
        case "Double":
            guard let destinationViewController = segue.destinationViewController as? SimpleValidationViewController else { return }
            destinationViewController.validationType = .Double
        default:
            break
        }
    }
}
