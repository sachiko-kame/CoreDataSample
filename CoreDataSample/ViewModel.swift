//
//  ViewModel.swift
//  CoreDataSample
//
//  Created by 水野祥子 on 2018/09/08.
//  Copyright © 2018年 sachiko. All rights reserved.
//

import UIKit
import CoreData

class ViewModel: NSObject {
    
    let myNotification = "updateNotification"
    let StartNotification = "StartNotification"
    
    let center = NotificationCenter.default
    var finishedUpdate:(() -> ())?
    var stertUpdate:(() -> ())?
    
    
    var fetchRequest:NSFetchRequest<Entity> = Entity.fetchRequest()
    var coreDaraManager:CoreDaraManager<Entity>
    
    deinit {
        center.removeObserver(self)
    }
    
    override init(){
        coreDaraManager = CoreDaraManager(fetchRequest:fetchRequest)
        super.init()
        center.addObserver(self,
                           selector: #selector(type(of: self).notified(notification:)),
                           name: NSNotification.Name(rawValue: myNotification),
                           object: nil)
        center.addObserver(self,
                           selector: #selector(type(of: self).started(notification:)),
                           name: NSNotification.Name(rawValue: StartNotification),
                           object: nil)
    }
    
    func sortallTap(){
        center.post(Notification(name:Notification.Name(rawValue: StartNotification)))
        fetchReset()
        //昇順のみ
        coreDaraManager.save(Do:{
            coreDaraManager.sortAllget(sortkey:"title", Do:{
                center.post(Notification(name:Notification.Name(rawValue: myNotification)))
            })
        })
    }
    
    func itemallGet(){
        center.post(Notification(name:Notification.Name(rawValue: StartNotification)))
        fetchReset()
        coreDaraManager.save(Do:{
            coreDaraManager.fetchResults(Do: {
                center.post(Notification(name:Notification.Name(rawValue: myNotification)))
            })
        })
    }
    
    func fetchReset(){
        coreDaraManager.fetchReset()
    }
    
    func itemAdd(title:String, discription:String){
        center.post(Notification(name:Notification.Name(rawValue: StartNotification)))
        let entity:Entity = Entity(context: coreDaraManager.viewContext)
        entity.title = title
        entity.discription = discription
        itemallGet()
    }
    
    func itemupdate(num:Int, title:String, discription:String){
        center.post(Notification(name:Notification.Name(rawValue: StartNotification)))
        if(coreDaraManager.isitem(num: num)){
            coreDaraManager.fetchRequests[num].title = title
            coreDaraManager.fetchRequests[num].discription = discription
            itemallGet()
        }
    }
    
    func itemdelete(num:Int){
        center.post(Notification(name:Notification.Name(rawValue: StartNotification)))
        if(coreDaraManager.isitem(num: num)){
            coreDaraManager.viewContext.delete(coreDaraManager.fetchRequests[num])
            coreDaraManager.fetchRequests.remove(at: num)
            itemallGet()
        }
    }
    
    func itemSerch(serchWord:String){
        center.post(Notification(name:Notification.Name(rawValue: StartNotification)))
        coreDaraManager.save(Do:{
            coreDaraManager.serchfetchResults(serch:serchWord, getCount: nil, Do: {
                center.post(Notification(name:Notification.Name(rawValue: myNotification)))
            })
        })
    }
    
    //指定削除
    //全削除
    
    
    @objc private func notified(notification: Notification) {
        self.finishedUpdate!()
    }
    
    @objc private func started(notification: Notification) {
        self.stertUpdate!()
    }
}

extension ViewModel:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreDaraManager.fetchRequests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        let title = coreDaraManager.fetchRequests[indexPath.row].title ?? ""
        let discription = coreDaraManager.fetchRequests[indexPath.row].discription ?? ""
        let Text = "タイトル:\(title) \nテキスト:\(discription)"
        cell.textLabel!.numberOfLines = 0
        cell.textLabel!.text = Text
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            itemdelete(num:indexPath.row)
        }
        
        center.post(Notification(name:Notification.Name(rawValue: myNotification)))
    }
}
