//
//  LocationViewController.swift
//  RxOperators
//
//  Created by 福田涼介 on 9/4/16.
//  Copyright © 2016 yuzushio. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LocationViewController: UIViewController {

    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LocationManager.instance.authorized
            .subscribeNext { authorized in
                print(authorized)
            }
            .addDisposableTo(disposeBag)
        
        LocationManager.instance.location
            .subscribeNext { location in
                print(location)
            }
            .addDisposableTo(disposeBag)
        
        LocationManager.instance.error
            .subscribeNext { [weak self] error in
                Alert.showAlert("Error", message: error.description, baseViewController: self)
            }
            .addDisposableTo(disposeBag)
    }
}
