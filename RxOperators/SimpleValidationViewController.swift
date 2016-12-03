//
//  SimpleValidationViewController.swift
//  RxOperators
//
//  Created by 福田涼介 on 9/3/16.
//  Copyright © 2016 yuzushio. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SimpleValidationViewController: UITableViewController {
    
    @IBOutlet weak var secondRowCell: UITableViewCell!
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    
    enum ValidationType {
        case single
        case double
    }
    
    enum MaxWordCount {
        case first
        case second
        
        var maxCount: Int {
            switch self {
            case .first:
                return 5
            case .second:
                return 8
            }
        }
    }
    
    var validationType: ValidationType!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "\(validationType)"
        
        let isSingleValidation = validationType == .single
        secondRowCell.isHidden = isSingleValidation
        
        if isSingleValidation {
            bindSingleValidation()
        } else {
            bindDoubleValidation()
        }
        
        bindButton()
    }
    
    fileprivate let disposeBag = DisposeBag()
    
    fileprivate func bindButton() {
        doneButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                Alert.showAlert("", message: "rx_tap!!", baseViewController: self)
            })
            .addDisposableTo(disposeBag)
    }
    
    fileprivate func bindSingleValidation() {
        firstTextField.rx.text.orEmpty
            .map { text -> Bool in
                let count = text.characters.count
                return count > 0 && count <= MaxWordCount.first.maxCount
            }
            .bindTo(doneButton.rx.isEnabled)
            .addDisposableTo(disposeBag)
    }
    
    fileprivate func bindDoubleValidation() {
        let isFirstTextFieldValid = firstTextField.rx.text.orEmpty
            .map { text -> Bool in
                let count = text.characters.count
                return count > 0 && count <= MaxWordCount.first.maxCount
        }
        
        let isSecondTextFieldValid = secondTextField.rx.text.orEmpty
            .map { text -> Bool in
                let count = text.characters.count
                return count > 0 && count <= MaxWordCount.second.maxCount
        }
        
        Observable
            .combineLatest(isFirstTextFieldValid, isSecondTextFieldValid) { $0 && $1 }
            .bindTo(doneButton.rx.isEnabled)
            .addDisposableTo(disposeBag)
    }
}
