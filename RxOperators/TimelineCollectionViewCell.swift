//
//  TimelineCollectionViewCell.swift
//  RxOperators
//
//  Created by 福田涼介 on 9/4/16.
//  Copyright © 2016 yuzushio. All rights reserved.
//

import UIKit

class TimelineCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    
    var timeline: Timeline? {
        didSet {
            guard let timeline = timeline else { return }
            
            imageView.image = UIImage(named: timeline.mainImage)
            priceLabel.text = "¥\(timeline.price)⚡️"
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
    }
}
