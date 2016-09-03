//
//  CircledBorderButton.swift
//  RxOperators
//
//  Created by 福田涼介 on 9/3/16.
//  Copyright © 2016 yuzushio. All rights reserved.
//

import UIKit

class CircledBorderButton: UIButton {
    
    private let defaultColor = UIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
    
    override var enabled: Bool {
        didSet {
            alpha = enabled ? 1.0 : 0.4
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 5
        clipsToBounds = true
        
        layer.borderWidth = 1
        layer.borderColor = defaultColor.CGColor
        
        setTitleColor(defaultColor, forState: .Normal)
    }
}
