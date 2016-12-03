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
    
    fileprivate let viewModel = TimelineViewModel()
    fileprivate let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindUI()
        bindTableView()
    }
    
    fileprivate func bindUI() {
        viewModel.elements
            .map { "Explore \($0.count) homes" }
            .bindTo(totalCountLabel.rx.text)
            .addDisposableTo(disposeBag)
    }
    
    fileprivate func bindTableView() {
        viewModel.elements
            .bindTo(tableView.rx.items(cellIdentifier: "Cell", cellType: TimelineTableViewCell.self)) { index, timeline, cell in
                cell.timeline = timeline
            }
            .addDisposableTo(disposeBag)
        
        tableView.rx.modelSelected(Timeline.self)
            .subscribe(onNext: { [weak self] timeline in
                Alert.showAlert("Selected House", message: timeline.title, baseViewController: self)
            })
            .addDisposableTo(disposeBag)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
