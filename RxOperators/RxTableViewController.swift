//
//  RxTableViewController.swift
//  RxOperators
//
//  Created by 福田涼介 on 9/4/16.
//  Copyright © 2016 yuzushio. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RxTableViewController: UITableViewController {
    
    @IBOutlet weak var totalCountLabel: UILabel!
    
    private let viewModel = TimelineViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindUI()
        bindTableView()
    }
    
    private func bindUI() {
        viewModel.elements
            .map { "Explore \($0.count) homes" }
            .bindTo(totalCountLabel.rx_text)
            .addDisposableTo(disposeBag)
    }
    
    private func bindTableView() {
        viewModel.elements
            .bindTo(tableView.rx_itemsWithCellIdentifier("Cell", cellType: TimelineTableViewCell.self)) { index, timeline, cell in
                cell.timeline = timeline
            }
            .addDisposableTo(disposeBag)
        
        tableView.rx_modelSelected(Timeline)
            .subscribeNext { [weak self] timeline in
                Alert.showAlert("Selected House", message: timeline.title, baseViewController: self)
            }
            .addDisposableTo(disposeBag)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200
    }
}
