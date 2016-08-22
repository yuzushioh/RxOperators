//
//  Sample1ViewController.swift
//  RxOperators
//
//  Created by 福田涼介 on 4/22/16.
//  Copyright © 2016 yuzushio. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class Sample1ViewController: UIViewController {
    
    @IBOutlet weak var rxButton: UIButton!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var rxOperator: Operator!
    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let description = Driver<String>
            .just(rxOperator.description)
        
        rxButton.rx_tap.asDriver()
            .withLatestFrom(description)
            .drive(descriptionTextView.rx_text)
            .addDisposableTo(disposeBag)
    }
}
