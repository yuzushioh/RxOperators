//
//  CircledImageView.swift
//  RxOperators
//
//  Created by 福田涼介 on 9/4/16.
//  Copyright © 2016 yuzushio. All rights reserved.
//

import UIKit

class CircledImageView: UIImageView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = layer.bounds.width/2
        clipsToBounds = true
    }
}
