//
//  Sample3ViewController.swift
//  RxOperators
//
//  Created by 福田涼介 on 4/22/16.
//  Copyright © 2016 yuzushio. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class Sample3ViewController: UIViewController {
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    let viewWillAppearTrigger = PublishSubject<Void>()
    let disposeBag = DisposeBag()
    
    var rxOperator: Operator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rx_sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .map { _ in }
            .bindTo(viewWillAppearTrigger)
            .addDisposableTo(disposeBag)
        
        let printText = Observable
            .just(())
        
        //ここもUIに関するところなので本来はDriverの方が向いている。
        Observable
            .of(
                Observable.never().takeUntil(viewWillAppearTrigger),
                printText
            )
            .concat()
            .map { _ in "concat発動" }
            .doOnNext { text in
                print(text)
            }
            .bindTo(textLabel.rx_text)
            .addDisposableTo(disposeBag)
        
        Driver
            .just(rxOperator.description)
            .drive(descriptionTextView.rx_text)
            .addDisposableTo(disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
