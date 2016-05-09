//
//  Qiita.swift
//  RxOperators
//
//  Created by 福田涼介 on 5/10/16.
//  Copyright © 2016 yuzushio. All rights reserved.
//

import Foundation
import Himotoki

struct Qiita: Decodable {
    
    static func decode(e: Extractor) throws -> Qiita {
        return Qiita()
    }
}