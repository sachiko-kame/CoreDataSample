//
//  CoreDataSampleUITests.swift
//  CoreDataSampleUITests
//
//  Created by 水野祥子 on 2018/08/27.
//  Copyright © 2018年 sachiko. All rights reserved.
//

import XCTest

class CoreDataSampleUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testSample(){
        
        let TestEntitys:[TestEntity] = [
            TestEntity(title:"あ", discription:"あり"),
            TestEntity(title:"か", discription:"かき"),
            TestEntity(title:"わ", discription:"わたがし"),
            TestEntity(title:"た", discription:"大変だ！")
        ]
    
        
        let app = XCUIApplication()
        let newbutton = app.buttons["新規アイテムの追加"]
        let resultbutton = app.buttons["検索結果の表示"]
        let sortresultbutton = app.buttons["sortして全てを表示"]
        let allbutton = app.buttons["全表示"]
        
        for item in TestEntitys {
            app.textFields["title"].tap()
            if(app.textFields["title"].value as! String != "" && app.textFields["title"].value as! String != "title"){
                app.textFields["title"].buttons["Clear text"].tap()
            }
            app.textFields["title"].typeText(item.title)
            
            
            app.textFields["discription"].tap()
            if(app.textFields["discription"].value as! String != "" && app.textFields["discription"].value as! String != "discription"){
                app.textFields["discription"].buttons["Clear text"].tap()
            }
            app.textFields["discription"].typeText(item.discription)
        
            newbutton.tap()
            app.buttons["Return"].tap()
            app.swipeUp()
        }
        
    
        app.textFields["検索したいTitleを入力してくだい。"].tap()
        app.textFields["検索したいTitleを入力してくだい。"].typeText("か")
        app.buttons["Return"].tap()
        app.swipeUp()
        
        resultbutton.tap()
        app.swipeUp()
        
        sortresultbutton.tap()
        allbutton.tap()
        app.swipeUp()
        

    }
}

struct TestEntity {
    var title:String
    var discription:String
}
