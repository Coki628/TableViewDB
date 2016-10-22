//
//  Cell.swift
//  TableViewDB
//
//  Created by Coki Kakegawa on 2016/08/26.
//  Copyright © 2016年 CokiLab. All rights reserved.
//

import UIKit

class Cell: UITableViewCell {

    @IBOutlet weak var msgLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var readLabel: UILabel!
    
    func setCell(item: Item) {
        
        //Itemオブジェクトの各要素をOutputのテキストに入れる
        msgLabel.text = item.message
        timeLabel.text = item.time
        
        if(item.read == 0) {
            readLabel.text = "未読"
        } else {
            readLabel.text = ""
        }
    }
}
