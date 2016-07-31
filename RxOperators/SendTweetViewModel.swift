//
//  SendTweetViewModel.swift
//  RxOperators
//
//  Created by 福田涼介 on 7/31/16.
//  Copyright © 2016 yuzushio. All rights reserved.
//

import Foundation
import RxSwift

class SendTweetViewModel {
    
    let text = PublishSubject<String>()
    let requestTrigger = PublishSubject<Void>()
    
    private let disposeBag = DisposeBag()
    
    init() {
        
    }
}
