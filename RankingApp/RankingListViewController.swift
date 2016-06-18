//
//  RankingListViewController.swift
//  RankingApp
//
//  Created by Teacher on 2016/06/18.
//  Copyright © 2016年 AKYLab. All rights reserved.
//

import UIKit

class RankingListViewController: UITableViewController {
    // ランキングのリスト情報
    let list = Feed.getRanking()
}

extension RankingListViewController {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return list.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.textLabel?.text = list[indexPath.row]
        
        return cell
    }
}