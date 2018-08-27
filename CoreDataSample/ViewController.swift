//
//  ViewController.swift
//  CoreDataSample
//
//  Created by 水野祥子 on 2018/08/27.
//  Copyright © 2018年 sachiko. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var List = NSMutableArray()

    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var discriptionTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        read()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func read(){
        //AppDelegateを使う用意をしておく
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //エンティティを操作するためのオブジェクトを作成
        let viewContext = appDelegate.persistentContainer.viewContext
        
        //どのエンティティからdataを取得してくるか設定
        let query:NSFetchRequest<Entity> = Entity.fetchRequest()
        
        do {
            //データを一括取得
            let fetchResults = try viewContext.fetch(query)
            
            //データの取得
            for result: AnyObject in fetchResults {
                let title:String? = result.value(forKey: "title") as? String ?? ""
                let discription: String? = result.value(forKey: "discription") as? String ?? ""
                
                print("🍀title:\(title) 内容:\(discription)")
                List.add(["title":title,"discription":discription])
            }
        } catch {
        }
    }

    @IBAction func tap(_ sender: Any) {
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //エンティティを操作するためのオブジェクトを作成
        let viewContext = appDelegate.persistentContainer.viewContext
        
        //ToDoエンティティオブジェクトを作成
        let ToDo = NSEntityDescription.entity(forEntityName: "Entity", in: viewContext)
        
        //ToDoエンティティにレコード（行）を挿入するためのオブジェクトを作成
        let newRecord = NSManagedObject(entity: ToDo!, insertInto: viewContext)
        
        //値のセット
        newRecord.setValue(titleTextField.text, forKey: "title") //値を代入
        newRecord.setValue(discriptionTextField.text, forKey: "discription") //値を代入
        
        do{
            //レコード（行）の即時保存
            try viewContext.save()
            
            //再読み込み
            read()
        } catch {
        }

    }
    
    
}

