//
//  TweetResponse.swift
//  RxOperators
//
//  Created by 福田涼介 on 5/8/16.
//  Copyright © 2016 yuzushio. All rights reserved.
//

import Foundation
import Himotoki

struct TweetResponse<E: Decodable>: TweetResponseType {
    typealias Element = E
    
    let elements: [Element]
}