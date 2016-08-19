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
            Operator(title: "Sample 2", description: "intervalは与えた時間ごとにIntのObservableを排出します！この場合だと毎5秒ごとにIntのObservableが排出されています。\n\nofは様々なObjectやtypeを一つのObservbaleにします！\n\nmergeは複数のストリームから排出されたObservablesを一つのストリームにまとめます。この場合だと毎5秒ごとに排出されるVoidストリーム(intervalTrigger)と、はじめの一回だけVoidを排出するストリーム(firstTrigger)をマージして一つのストリームにしています。mergeする場合ストリームは同じタイプである必要があります。\n\nちなみにmap { _ in --- }でストリームのタイプを---の物に変えています。例(.map { _ in String(operators(rawValue: arc4random_uniform(5))!) }　Void -> String)"),
            Operator(title: "Sample 3", description: "concatは複数のストリームが１つのストリームとして扱えるように複数のストリームをくっつけます。concantは１つ目のストリームがcompletedするまで二つ目以降のストリームをsubscribeするのを待ちます。この場合、何も排出しないnever()ストリームを作り、viewWillAppearTriggerがonNextされたタイミングでtakeUntil()を使いonCompltedします。そのタイミングで二つ目のストリームをsubscribeします！\n\ntakeUntil()は指定したストリームを見て、そのストリームがObservableを排出したタイミングで購読しているストリームをonCompletedします。\n\ndoOnNextはsubscribeNextと違い、後にbindTo(Drive)を使うことができます。"),
            Operator(title: "Sample 4", description: "簡単なフォームバリデーションのサンプルです。"),
            Operator(title: "Sample 5", description: ""),
            Operator(title: "Sample 6", description: "")
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
                    self?.pushToViewController(vc)
                case 1:
                    let vc = storyboard.instantiateViewControllerWithIdentifier("Sample2ViewController") as! Sample2ViewController
                    vc.rxOperator = rxOperator
                    self?.pushToViewController(vc)
                case 2:
                    let vc = storyboard.instantiateViewControllerWithIdentifier("Sample3ViewController") as! Sample3ViewController
                    vc.rxOperator = rxOperator
                    self?.pushToViewController(vc)
                case 3:
                    let vc = storyboard.instantiateViewControllerWithIdentifier("Sample4ViewController") as! Sample4ViewController
                    vc.rxOperator = rxOperator
                    self?.pushToViewController(vc)
                case 4:
                    let vc = storyboard.instantiateViewControllerWithIdentifier("Sample5ViewController") as! Sample5ViewController
                    vc.rxOperator = rxOperator
                    self?.pushToViewController(vc)
                default:
                    break
                }
            }
            .addDisposableTo(disposeBag)
    }
    
    private func pushToViewController(viewController: UIViewController) {
        self.navigationController?.pushViewController(viewController, animated: true)
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
