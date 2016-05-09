//
//  TweetService.swift
//  RxOperators
//
//  Created by 福田涼介 on 5/6/16.
//  Copyright © 2016 yuzushio. All rights reserved.
//

import Foundation
import APIKit

class TweetService {
    struct GetTweets: TwitterRequestType {
       
        typealias Response = TweetResponse<Tweet>
        
        var path: String {
            return "statuses/home_timeline.json"
        }
        
        var method: HTTPMethod {
            return .GET
        }
        
        var parameters: [String : AnyObject] {
            return [:]
        }
        
        var HTTPHeaderFields: [String : String] {
            return [:]
        }
    }
}
