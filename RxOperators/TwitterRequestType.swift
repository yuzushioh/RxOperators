//
//  TwitterRequestType.swift
//  RxOperators
//
//  Created by 福田涼介 on 5/6/16.
//  Copyright © 2016 yuzushio. All rights reserved.
//

import Foundation
import APIKit
import Himotoki

protocol TwitterRequestType: RequestType {
    
}

extension TwitterRequestType {
    var baseURL: NSURL {
        return NSURL(string: "https://api.twitter.com/1.1/")!
    }
}

extension TwitterRequestType {
    func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) -> Self.Response? {
        guard let object = object as? Response else {
            return nil
        }
        return object
    }
}

extension TwitterRequestType where Response: Decodable {
    func responseFromObject(object: AnyObject, URLResponse: NSHTTPURLResponse) -> Response? {
        return try? decodeValue(object)
    }
}

