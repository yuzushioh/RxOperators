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
    
    @IBOutlet weak var operatorLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    private let disposeBag = DisposeBag()
    
    var rxOperator: Operator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        enum operators: UInt32 {
            case rx_sentMessage
            case map
            case interval
            case of
            case merge
        }
        
        let firstTrigger = Driver
            .just(())
        
        let intervalTrigger = Driver<Int>
            .interval(5.0)
            .map { _ in }
        
        let mergedTrigger = Driver
            .of(
                firstTrigger,
                intervalTrigger
            )
            .merge()
        
        let operatorName = mergedTrigger
            .map { _ in String(operators(rawValue: arc4random_uniform(5))!) }
        
        operatorName
            .drive(operatorLabel.rx_text)
            .addDisposableTo(disposeBag)
        
        Driver
            .just(rxOperator.description)
            .drive(descriptionTextView.rx_text)
            .addDisposableTo(disposeBag)
    }
}
