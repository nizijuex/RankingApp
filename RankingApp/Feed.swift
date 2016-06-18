//
//  Feed.swift
//  RankingApp
//
//  Created by Teacher on 2016/06/18.
//  Copyright © 2016年 AKYLab. All rights reserved.
//

import Foundation

class Feed {
    // URLからランキング情報のJSONを取得
    static func getJSON() -> [String:AnyObject] {
        let urlStr = "https://itunes.apple.com/jp/rss/newfreeapplications/limit=100/json"
        // Forced unwrapはあまり推奨されないが、NSURLが空の場合はどうしもないのでここではForced unwrapしてしまう
        let url = NSURL(string: urlStr)!
        let data = NSData(contentsOfURL: url)!
        // 取得したJSONオブジェクトの内容は書き変えずにそのまま利用するので、AllowFragments を指定
        let json = try! NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
        
        return [:]
    }
    
    // ランキングの情報を取得するためのメソッド
    // 一旦、アプリ名だけを返す
    static func getRanking() -> [String] {
        // URLからデータの取得
        
        
        return [
            "A",
            "B",
            "C",
        ]
    }
}
