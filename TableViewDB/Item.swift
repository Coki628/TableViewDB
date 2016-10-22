//
//  Item.swift
//  TableViewDB
//
//  Created by Coki Kakegawa on 2016/08/26.
//  Copyright © 2016年 CokiLab. All rights reserved.
//

import Foundation

class Item {    //セルに必要なデータのクラス
    
    var message:String!
    var time:String!
    var read:NSNumber!
    
    init(message:String!, time:String!, read:NSNumber!) {
        
        self.message = message
        self.time = time
        self.read = read
    }
}

