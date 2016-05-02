//
//  Sample5TableViewCell.swift
//  RxOperators
//
//  Created by 福田涼介 on 4/30/16.
//  Copyright © 2016 yuzushio. All rights reserved.
//

import UIKit
import RxSwift

class Sample5TableViewCell: UITableViewCell {

    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var likedLabel: UILabel!
    
    var disposeBag = DisposeBag()
    
    var item: Item! {
        didSet {
            itemNameLabel.text = item.name
            likedLabel.text = item.isLiked ? "👍🏻ライクされています" : "👎🏻ライクされていません"
        }
    }
}
