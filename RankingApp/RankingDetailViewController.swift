//
//  RankingDetailViewController.swift
//  RankingApp
//
//  Created by Teacher on 2016/06/25.
//  Copyright © 2016年 AKYLab. All rights reserved.
//

import UIKit

/// ランキング詳細画面用ViewController
class RankingDetailViewController: UIViewController {
    /// 表示対象アプリの情報を保持したItem
    var item: Item!
    
    // 個別のOutlet宣言
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    // 実際に画面が読み込まれた時の処理
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = item.title
        authorLabel.text = item.author
        categoryLabel.text = item.category
        releaseDateLabel.text = item.releaseDate
        descriptionTextView.text = item.description
        
        let imgData = NSData(contentsOfURL: item.imgUrl)!
        img.image = UIImage(data: imgData)
    }
}
