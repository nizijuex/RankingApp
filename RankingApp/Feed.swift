//
//  Feed.swift
//  RankingApp
//
//  Created by Teacher on 2016/06/18.
//  Copyright © 2016年 AKYLab. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import AlamofireSwiftyJSON

/// 個別のアプリの情報を格納するクラス
class Item {
    /// アプリ名
    let title: String
    /// アプリアイコンURL
    let imgUrl: NSURL
    /// 説明文
    let description: String
    /// ストアへのリンク
    let linkUrl: NSURL
    /// 作成者
    let author: String
    /// カテゴリ
    let category: String
    /// リリース日
    let releaseDate: String
    
    init(json: JSON) {
        // アプリ名
        title = json["title"]["label"].stringValue
        
        // アプリアイコンURL
        var urlStr = json["im:image"][0]["label"].stringValue
        imgUrl = NSURL(string: urlStr)!
        
        // 説明文
        description = json["summary"]["label"].stringValue
        
        // ストアへのリンク
        urlStr = json["link"]["attributes"]["href"].stringValue
        linkUrl = NSURL(string: urlStr)!
        
        // 作成者
        author = json["im:artist"]["label"].stringValue
        
        // カテゴリ
        category = json["category"]["attributes"]["label"].stringValue
        
        // リリース日
        releaseDate = json["im:releaseDate"]["attributes"]["label"].stringValue
    }
}

class Feed {
    /// URLからランキング情報のJSONを取得
    static func getJSON(completion: JSON -> Void) {
        let urlStr = "https://itunes.apple.com/jp/rss/topfreeapplications/limit=10/json"
        
        Alamofire.request(.GET, urlStr).responseSwiftyJSON { res in
            // レスポンスを受け取った時の処理
            let json = res.result.value!
            completion(json)
        }
    }    

    /**
     ランキングの情報を取得するためのメソッド
     一旦、アプリ名だけを返す
    */
    static func getRanking(completion: [Item] -> Void) {
        // URLからデータの取得
        getJSON { json in
            let appList = json["feed"]["entry"].arrayValue
            let titleList = appList.map { Item(json: $0) }
            
            completion(titleList)
        }
    }
}
