//
//  ViewController.swift
//  TableViewDB
//
//  Created by Coki Kakegawa on 2016/08/26.
//  Copyright © 2016年 CokiLab. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var message: [String!] = []
    var time: [String!] = []
    var read: [NSNumber!] = []
    
    @IBOutlet weak var msgField: UITextField!
    
    @IBAction func writeBtn(sender: AnyObject) {
        
        writeData()
        readData()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // 書き込み処理
    func writeData() {
        //CoreDataの読み込み
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext
        //対象のEntityを選択して、新しいデータを入れる場所を作成
        let entity: NSEntityDescription! = NSEntityDescription.entityForName("Messages", inManagedObjectContext: context)
        let newData = Messages(entity: entity, insertIntoManagedObjectContext: context)
        
        //データの追加
        newData.message = msgField.text
        newData.time = DateUtils.stringFromDate(NSDate(), format: "yyyy-MM-dd HH:mm:ss")
        newData.read = 0
        //保存
        try! context.save()     //try!ってやればdo/catchやんなくてもいい
    }
    
    // 読み込み処理
    func readData() {
        //CoreDataの読み込み
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext
        //対象のEntityを選択
        let request: NSFetchRequest = NSFetchRequest(entityName: "Messages")
        
        //降順に並べる
        let sortDescripter = NSSortDescriptor(key: "time", ascending: false)
        request.sortDescriptors = [sortDescripter]
        
        let results: NSArray! = try! context.executeFetchRequest(request)
        
        //中身からっぽだったら何もしない
        if(results.count == 0){
            print("データがからっぽだよ")
            return;     //メソッドを抜けるreturnは;つける
        }
        
        //いったん空にして
        message = []
        time = []
        read = []
        //データを配列に突っ込む
        for data in results {
            message.append(data.message)
            time.append(data.time)
            read.append(data.read)
        }
        
        // コンソールに表示
//        print(results[0].message)
        print(message[0])
        print(time[0])
        print(read[0])
    
    }
    
    class DateUtils {
        class func dateFromString(string: String, format: String) -> NSDate {
            let formatter: NSDateFormatter = NSDateFormatter()
            formatter.dateFormat = format
            return formatter.dateFromString(string)!
        }
        
        class func stringFromDate(date: NSDate, format: String) -> String {
            let formatter: NSDateFormatter = NSDateFormatter()
            formatter.dateFormat = format
            return formatter.stringFromDate(date)
        }
    }


}

