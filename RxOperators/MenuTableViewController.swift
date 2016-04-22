//
//  MenuTableViewController.swift
//  RxOperators
//
//  Created by 福田涼介 on 4/22/16.
//  Copyright © 2016 yuzushio. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MenuTableViewController: UITableViewController {
    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Operators"
        navigationController?.navigationBar.barStyle = .Black
        
        bindTableView()
    }
    
    private func bindTableView() {
        let operators: Driver<[Operator]> = Driver.just([
            Operator(title: "Sample 1", description: "rx_tapはUIButtonがタップされた時にVoidを流すコントロールイベントです！\n\njustは特定のObservableを排出するストリームを作ります。この場合は特定のstringを排出しています。\n\nflatMapはストリームにストリームをくっつける役割を果たします。この場合はrx_tapのVoidストリームが来た時にDriver<Srting>を合体させます。この時点でrx_tapのストリームはStringのストリームに変わります。\n\nDriverについては別記事でまとめてあるのでそちらを確認してください。http://qiita.com/yuzushioh/items/0a4483502c5c8569790a \n\nrx_textはUItextField, UITextView, UILabelのコントロールプロパティーです"),
            Operator(title: "Sample 2", description: "")
            ])
        
        operators.asDriver()
            .drive(tableView.rx_itemsWithCellIdentifier("TitleCell")) { _, rxOperator, cell in
                cell.textLabel?.text = rxOperator.title
            }
            .addDisposableTo(disposeBag)
        
        tableView.rx_itemSelected
            .withLatestFrom(operators) { indexPath, operators in
                return (operators[indexPath.row], indexPath)
            }
            .subscribeNext { [weak self] (rxOperator, indexPath) in
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                switch indexPath.row {
                case 0:
                    let vc = storyboard.instantiateViewControllerWithIdentifier("Sample1ViewController") as! Sample1ViewController
                    vc.rxOperator = rxOperator
                    self?.navigationController?.pushViewController(vc, animated: true)
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
}

struct Operator {
    let title: String
    let description: String
}
