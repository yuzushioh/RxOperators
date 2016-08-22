//
//  Sample5DetailViewController.swift
//  RxOperators
//
//  Created by 福田涼介 on 5/3/16.
//  Copyright © 2016 yuzushio. All rights reserved.
//

import UIKit
import RxSwift

class Sample5DetailViewController: UIViewController {
    
    var item: Item!
    
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if item.isLiked {
            likeButton.setTitle("👍🏻ライクされています", forState: .Normal)
        } else {
            likeButton.setTitle("👎🏻ライクされていません", forState: .Normal)
        }
        
        nameLabel.text = item.name
        
        let buttonTapped = likeButton.rx_tap.asDriver()
            
        buttonTapped
            .map { [unowned self] _ -> Item in
                var item = self.item
                item.isLiked = item.isLiked ? false : true
                return item
            }
            .drive(LikeSubject.ItemDidLikeNotification)
            .addDisposableTo(disposeBag)
        
        buttonTapped
            .driveNext { [weak self] _ in
                guard let strongSelf = self else { return }
                if strongSelf.item.isLiked {
                    strongSelf.likeButton.setTitle("👎🏻ライクされていません", forState: .Normal)
                } else {
                    strongSelf.likeButton.setTitle("👍🏻ライクされています", forState: .Normal)
                }
            }
            .addDisposableTo(disposeBag)
    }
}