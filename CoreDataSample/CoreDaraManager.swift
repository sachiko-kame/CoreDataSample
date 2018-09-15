//
//  CoreDaraManager.swift
//  CoreDataSample
//
//  Created by 水野祥子 on 2018/08/30.
//  Copyright © 2018年 sachiko. All rights reserved.
//

import UIKit
import CoreData

enum coreDataResult<T>{
    case success(T)
    case failure(Error)
    
    public init(value: T) {
        self = .success(value)
    }
    
    public init(error: NSError) {
        self = .failure(error)
    }
}

class CoreDaraManager<T:NSManagedObject>: NSObject {
    
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    let viewContext:NSManagedObjectContext
    var fetchRequest:NSFetchRequest<T>
    var fetchRequests:[T] = []
    var latestmessage:String = ""

    init(fetchRequest:NSFetchRequest<T>){
       
       viewContext = appDelegate.persistentContainer.viewContext
       self.fetchRequest = fetchRequest
    
    }
    
    func isitem(num:Int) ->Bool {
        if(num > fetchRequests.count){
            latestmessage = "アイテムがありません"
            return false
        }else{
            return true
        }
    }
    
    func serchfetchResults<serchItem>(key:String = "title", serch:serchItem, getCount:Int?, Do:(()->())){
        if(getCount != nil){
            self.fetchRequest.fetchBatchSize = getCount!
        }
        
        self.fetchRequest.predicate = NSPredicate(format: "\(key) == %@", serch as! CVarArg )
        
        do {
            self.fetchRequests = try viewContext.fetch(self.fetchRequest)
            latestmessage = "成功"
            Do()
        } catch {
            let nserror = error as NSError
            latestmessage = "\(nserror.localizedDescription)"
            Do()
        }
    }
    
    func sortAllget(sortkey:String = "title", Do:(()->())){
        let sortSample = NSSortDescriptor(key: sortkey, ascending:true)
        self.fetchRequest.sortDescriptors = [sortSample]
        do {
            self.fetchRequests = try viewContext.fetch(self.fetchRequest)
            latestmessage = "成功"
            Do()
        } catch {
            let nserror = error as NSError
            latestmessage = "\(nserror.localizedDescription)"
            Do()
        }
    }
    
    func fetchResults(Do:(()->())){
        do {
            self.fetchRequests = try viewContext.fetch(self.fetchRequest)
            latestmessage = "成功"
            Do()
        } catch {
            let nserror = error as NSError
            latestmessage = "\(nserror.localizedDescription)"
            Do()
        }
    }
    
    func fetchReset(){
        fetchRequest.predicate = nil
        fetchRequest.sortDescriptors = nil
    }
    
    func save(Do:(()->())){
        /*
         値の更新なしで更新したいためコメントアウト
         viewContext.hasChanges
         */
        do {
            try viewContext.save()
            latestmessage = "成功"
            Do()
        }catch{
            let nserror = error as NSError
            latestmessage = "\(nserror.localizedDescription)"
            Do()
        }
    }
}
