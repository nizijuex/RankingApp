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
        
        // 表示順 = 順位のはず
        let rank = indexPath.row + 1
        
        let cell = UITableViewCell()
        // 文字列中で \(変数名) とすると、変数展開ができる
        cell.textLabel?.text = "\(rank)位 \(list[indexPath.row])"
        
        return cell
    }
}