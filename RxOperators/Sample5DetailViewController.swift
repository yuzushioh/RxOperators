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
            .driveNext { [weak self] _ in
                guard let item = self?.item else { return }
                
                var updatedItem = item
                if item.isLiked {
                    updatedItem.isLiked = false
                } else {
                    updatedItem.isLiked = true
                }
                
                LikeSubject.ItemDidLikeNotification
                    .onNext(updatedItem)
            }
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}