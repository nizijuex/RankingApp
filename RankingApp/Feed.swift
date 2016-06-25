//
//  Feed.swift
//  RankingApp
//
//  Created by Teacher on 2016/06/18.
//  Copyright © 2016年 AKYLab. All rights reserved.
//

import Foundation

/// JSONデータの参照を簡略化させるための汎用クラス
class Object {
    let data: AnyObject
    
    // 引数名の前に _ を指定すると、仮引数のラベルをなしにできる
    init(_ data: AnyObject) {
        self.data = data
    }
    // subscript は添え字指定時に呼び出されるメソッド定義
    // hoge[0]
    subscript (index: Int) -> Object {
        return Object((data as! Array)[index])
    }
    // hoge["fuga"]
    subscript (index: String) -> Object {
        return Object((data as! Dictionary)[index]!)
    }
    // 計算型プロパティの定義
    var arrayValue: [Object] {
        return (data as! Array).map { Object($0) }
    }
    var stringValue: String {
        return data as! String
    }
}

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
    
    init(json: Object) {
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
    static func getJSON() -> Object {
        let urlStr = "https://itunes.apple.com/jp/rss/topfreeapplications/limit=10/json"
        // Forced unwrapはあまり推奨されないが、NSURLが空の場合はどうしもないのでここではForced unwrapしてしまう
        let url = NSURL(string: urlStr)!
        let data = NSData(contentsOfURL: url)!
        // 取得したJSONオブジェクトの内容は書き変えずにそのまま利用するので、AllowFragments を指定
        let json = try! NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
        
        return Object(json)
    }
    

    /**
     ランキングの情報を取得するためのメソッド
     一旦、アプリ名だけを返す
    */
    static func getRanking() -> [Item] {
        // URLからデータの取得
        let json = getJSON()
        
        let appList = json["feed"]["entry"].arrayValue
        
        let titleList = appList.map { Item(json: $0) }
        /* 上の書き方は下と同義
        let titleList = appList.map { app in
            Item(json: app)
        }
        */
 
        
        return titleList
    }
}
