//
//  TimelineTableViewCell.swift
//  RxOperators
//
//  Created by 福田涼介 on 9/4/16.
//  Copyright © 2016 yuzushio. All rights reserved.
//

import UIKit

class TimelineTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var timeline: Timeline? {
        didSet {
            guard let timeline = timeline else { return }
            
            mainImageView.image = UIImage(named: timeline.mainImage)
            titleLabel.text = timeline.title
            priceLabel.text = "¥\(timeline.price)⚡️"
        }
    }
}
