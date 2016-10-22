//
//  ListViewController.swift
//  TableViewDB
//
//  Created by Coki Kakegawa on 2016/08/26.
//  Copyright © 2016年 CokiLab. All rights reserved.
//

import UIKit
import CoreData

class ListViewController: UITableViewController {
    
    var items = [Item]()        //配列にまとめて格納
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        readData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initDB() {
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext
        let entity: NSEntityDescription! = NSEntityDescription.entityForName("Messages", inManagedObjectContext: context)
        let newData = Messages(entity: entity, insertIntoManagedObjectContext: context)
        
        //なぜかこの初期化？がないと読み込みで型とかうまくいかない。実行してないのに…謎。
        newData.message = ""
        newData.time = ""
        newData.read = 0
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
        
        //データを各Itemに突っ込む
        for data in results {
            items.append(Item(message: data.message, time: data.time, read: data.read))
        }
        
        // コンソールに表示
        print(items[0].message)
    }
    
    //未読の更新処理
    func updateData(row: Int) {
        //CoreDataの読み込み
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext
        //対象のEntityを選択
        let request: NSFetchRequest = NSFetchRequest(entityName: "Messages")
        
        //降順に並べる
        let sortDescripter = NSSortDescriptor(key: "time", ascending: false)
        request.sortDescriptors = [sortDescripter]
        
        let results: NSArray! = try! context.executeFetchRequest(request)
        
        //該当箇所のフラグを1に
        let item = results[row] as! NSManagedObject
        item.setValue(1, forKey: "read")
        try! context.save()
        //今表示してるテーブルビューもこれで更新
        items[row].read = 1
        self.tableView.reloadData()
        
        print("save ok")
    }
    
    //表示させるセルの数を返す
    override func tableView(tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        
        return items.count
    }
    
    //セルの数だけ呼ばれてセルの内容を返す
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! Cell
        cell.setCell(items[indexPath.row])
        return cell
    }
    
    //セルをタップしたら呼ばれる
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        updateData(indexPath.row)
    }
    
/*    override func viewWillAppear(animated: Bool) {
    }
    override func viewDidAppear(animated: Bool) {
    }*/

    //遷移先へ値を送る
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let indexPath = self.tableView.indexPathForSelectedRow {
            
            let item = items[indexPath.row]         //選択されたセルに使われてるItemオブジェクトを呼ぶ
            let controller = segue.destinationViewController as! DetailViewController
            controller.message = item.message
            controller.time = item.time        //遷移先のラベルにオブジェクトの各値を入れる
        }
    }
}

