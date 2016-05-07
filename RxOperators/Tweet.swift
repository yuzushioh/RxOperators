//
//  Tweet.swift
//  RxOperators
//
//  Created by 福田涼介 on 5/7/16.
//  Copyright © 2016 yuzushio. All rights reserved.
//

import Foundation
import Himotoki

struct Tweet: Decodable {
    
    static func decode(e: Extractor) throws -> Tweet {
        return Tweet()
    }
}