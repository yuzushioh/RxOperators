//
//  TweetResponseType.swift
//  RxOperators
//
//  Created by 福田涼介 on 5/7/16.
//  Copyright © 2016 yuzushio. All rights reserved.
//

import Foundation
import Himotoki

protocol TweetResponseType {
    associatedtype Element: Decodable
    
    var elements: [Element] { get }
    
    init(elements: [Element])
}