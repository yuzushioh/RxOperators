//
//  MenuTableViewController.swift
//  RxOperators
//
//  Created by 福田涼介 on 4/22/16.
//  Copyright © 2016 yuzushio. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {
    
    let operators: [Operator] = [
        Operator(title: "map", description: ""),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Operators"
        navigationController?.navigationBar.barStyle = .Black
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return operators.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TitleCell", forIndexPath: indexPath)
        
        cell.textLabel?.text = operators[indexPath.row].title

        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }

}

struct Operator {
    let title: String
    let description: String
}
