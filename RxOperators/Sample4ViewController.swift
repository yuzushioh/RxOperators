//
//  Sample4ViewController.swift
//  RxOperators
//
//  Created by 福田涼介 on 4/23/16.
//  Copyright © 2016 yuzushio. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class Sample4ViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var usernameValidationLabel: UILabel!
    @IBOutlet weak var passwordValidationLabel: UILabel!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var signUpButton: UIButton!
    
    private let disposeBag = DisposeBag()
    
    private let minWordCount = 3
    
    var rxOperator: Operator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let description = Driver
            .just(rxOperator.description)
        
        let usernameValidation = usernameTextField.rx_text.asDriver()
            .map { [weak self] username -> Bool in
                return username.characters.count > self?.minWordCount
            }
        
        let passwordValidation = passwordTextField.rx_text.asDriver()
            .map { [weak self] password -> Bool in
                return password.characters.count > self?.minWordCount
            }
        
        usernameValidation
            .drive(usernameValidationLabel.rx_hidden)
            .addDisposableTo(disposeBag)
        
        passwordValidation
            .drive(passwordValidationLabel.rx_hidden)
            .addDisposableTo(disposeBag)
        
        let signUpButtonEnabled = [usernameValidation, passwordValidation]
            .combineLatest { !$0.contains(false) }
        
        signUpButtonEnabled
            .drive(signUpButton.rx_enabled)
            .addDisposableTo(disposeBag)
        
        signUpButtonEnabled
            .driveNext { [weak self] valid in
                self?.signUpButton.backgroundColor = valid ?
                    UIColor(red: 135/255, green: 132/255, blue: 200/255, alpha: 1) : UIColor(red: 135/255, green: 132/255, blue: 200/255, alpha: 0.5)
            }
            .addDisposableTo(disposeBag)
        
        signUpButton.rx_tap.asDriver()
            .flatMap { _ in
                return description
            }
            .drive(descriptionTextView.rx_text)
            .addDisposableTo(disposeBag)
    }
}
