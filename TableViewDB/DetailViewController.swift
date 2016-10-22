//
//  DetailViewController.swift
//  TableViewDB
//
//  Created by Coki Kakegawa on 2016/08/26.
//  Copyright © 2016年 CokiLab. All rights reserved.
//

import UIKit

class DetailViewController : UIViewController {
    
    @IBOutlet weak var msgLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    //一覧画面から値を受け取るための変数
    var message:String!
    var time:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        msgLabel.text = message
        timeLabel.text = time
        
        msgLabel.sizeToFit()
        msgLabel.numberOfLines = 0      //サイズ合わせと行数無制限で勝手に折り返してくれる
    }
}
