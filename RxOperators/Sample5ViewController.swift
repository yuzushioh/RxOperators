//
//  Sample5ViewController.swift
//  RxOperators
//
//  Created by 福田涼介 on 4/23/16.
//  Copyright © 2016 yuzushio. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class Sample5ViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    var rxOperator: Operator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
