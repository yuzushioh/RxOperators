//
//  TimelineViewModel.swift
//  RxOperators
//
//  Created by 福田涼介 on 9/4/16.
//  Copyright © 2016 yuzushio. All rights reserved.
//

import RxSwift
import RxCocoa

final class TimelineViewModel {
    
    let elements: Observable<[Timeline]>
    
    init() {
        elements = Observable.of(Timeline.values)
    }
}
