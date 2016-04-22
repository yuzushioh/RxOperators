//
//  Sample2ViewController.swift
//  RxOperators
//
//  Created by 福田涼介 on 4/22/16.
//  Copyright © 2016 yuzushio. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class Sample2ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rx_sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
