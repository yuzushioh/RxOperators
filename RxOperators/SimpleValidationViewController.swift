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
        case Single
        case Double
    }
    
    enum MaxWordCount {
        case First
        case Second
        
        var maxCount: Int {
            switch self {
            case .First:
                return 5
            case .Second:
                return 8
            }
        }
    }
    
    var validationType: ValidationType!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "\(validationType)"
        
        let isSingleValidation = validationType == .Single
        secondRowCell.hidden = isSingleValidation
        
        if isSingleValidation {
            bindSingleValidation()
        } else {
            bindDoubleValidation()
        }
        
        bindButton()
    }
    
    private let disposeBag = DisposeBag()
    
    private func bindButton() {
        doneButton.rx_tap
            .subscribeNext { [weak self] _ in
                Alert.showAlert("", message: "rx_tap!!", baseViewController: self)
            }
            .addDisposableTo(disposeBag)
    }
    
    private func bindSingleValidation() {
        firstTextField.rx_text
            .map { text -> Bool in
                let count = text.characters.count
                return count > 0 && count <= MaxWordCount.First.maxCount
            }
            .bindTo(doneButton.rx_enabled)
            .addDisposableTo(disposeBag)
    }
    
    private func bindDoubleValidation() {
        let isFirstTextFieldValid = firstTextField.rx_text
            .map { text -> Bool in
                let count = text.characters.count
                return count > 0 && count <= MaxWordCount.First.maxCount
        }
        
        let isSecondTextFieldValid = secondTextField.rx_text
            .map { text -> Bool in
                let count = text.characters.count
                return count > 0 && count <= MaxWordCount.Second.maxCount
        }
        
        Observable
            .combineLatest(isFirstTextFieldValid, isSecondTextFieldValid) { $0 && $1 }
            .bindTo(doneButton.rx_enabled)
            .addDisposableTo(disposeBag)
    }
}
