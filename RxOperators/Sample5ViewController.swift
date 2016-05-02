//
//  Sample5ViewController.swift
//  RxOperators
//
//  Created by 福田涼介 on 4/23/16.
//  Copyright © 2016 yuzushio. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class Sample5ViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let disposeBag = DisposeBag()
    
    var rxOperator: Operator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let items = Driver.just([
            Item(id: 1, name: "Instagram", isLiked: false),
            Item(id: 2, name: "Facebook", isLiked: true),
            Item(id: 3, name: "Twitter", isLiked: false),
            Item(id: 4, name: "Mercari", isLiked: true),
            Item(id: 5, name: "Atte", isLiked: false),
            Item(id: 6, name: "Line", isLiked: true)
        ])
        
        items
            .drive(tableView.rx_itemsWithCellIdentifier("Cell", cellType: Sample5TableViewCell.self)) { index, item, cell in
                cell.item = item
                cell.disposeBag = DisposeBag()
                
                LikeSubject.ItemDidLikeNotification
                    .subscribeNext { item in
                        print(item)
                    }
                    .addDisposableTo(cell.disposeBag)
            }
            .addDisposableTo(disposeBag)
        
        tableView
            .rx_setDelegate(self)
            .addDisposableTo(disposeBag)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
}

final class LikeSubject {
    static let ItemDidLikeNotification = PublishSubject<Item>()
}

struct Item {
    let id: Int
    let name: String
    let isLiked: Bool
}
