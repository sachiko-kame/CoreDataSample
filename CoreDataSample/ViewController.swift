//
//  ViewController.swift
//  CoreDataSample
//
//  Created by 水野祥子 on 2018/08/27.
//  Copyright © 2018年 sachiko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var viewModel = ViewModel()

    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var discriptionTextField: UITextField!
    
    @IBOutlet weak var SerchWordTextField: UITextField!
    
    
    @IBOutlet weak var ResultMessage: UILabel!
    
    @IBOutlet weak var showTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        showTable.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        showTable.delegate = viewModel
        showTable.dataSource = viewModel
    
        viewModel.finishedUpdate = {
            self.showTable.reloadData()
            self.ResultMessage.text = self.viewModel.coreDaraManager.latestmessage
            print("☎️結果表示")
        }
        
        viewModel.stertUpdate = {
            self.ResultMessage.text = "処理中…"
            print("☎️処理中")
        }
        
        
        viewModel.itemallGet()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func tap(_ sender: Any) {
        viewModel.itemAdd(title: titleTextField.text!, discription:  discriptionTextField.text!)
    }
    @IBAction func SerchTitle(_ sender: Any) {
        viewModel.itemSerch(serchWord:SerchWordTextField.text!)
    }
    @IBAction func allGetTap(_ sender: Any) {
        viewModel.itemallGet()
        
    }
    @IBAction func sortAllGetTap(_ sender: Any) {
        viewModel.sortallTap()
    }
}

