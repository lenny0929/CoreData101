//
//  ViewController.swift
//  CoreData_101
//
//  Created by Lenny on 2018/2/24.
//  Copyright © 2018年 Lenny. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController {

    private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        // 更新的程式碼
        self.addItems(name: "iPhoneX 64GB", price: 32900)
        showItems()
        updateItems()
        showItems()
        
    }
    
    
    func addItems(name:String, price:Int32) {
        let item = NSEntityDescription.insertNewObject(forEntityName: "Items", into: context ) as! Items
        item.name = name
        item.price = price
        appDelegate.saveContext()
        
    }
    
    func showItems() {
        
        let request = NSFetchRequest<Items>(entityName: "Items" )
        
        do {
            
            let results = try context.fetch(request)
    
            for result in results {
                print("Items Name: \(result.name!), Price: \(result.price)")
            }
            
        }catch{
            fatalError("Failed to fetch data: \(error)")
        }
        
    }

    func cleanItems() {
        
       let request = Items.fetchRequest() as NSFetchRequest<Items>

        // 將iPhoneX 找出來
        let item_name = "iPhone 6s 16GB"
        request.predicate = NSPredicate(format: "name CONTAINS[cd] %@", item_name)
      
        do {
            let iphoneXs = try context.fetch(request)
            for iphoneX in iphoneXs {
                context.delete(iphoneX)
            }
            appDelegate.saveContext()
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
    }
    
    func updateItems() {
        
        let request = Items.fetchRequest() as NSFetchRequest<Items>
        
        // 將iPhoneX 找出來
        let item_name = "iPhoneX 64GB"
        request.predicate = NSPredicate(format: "name CONTAINS[cd] %@", item_name)
        
        do {
            let iphoneXs = try context.fetch(request)
            
            if (iphoneXs.count > 0){
                let product = iphoneXs[0]
                product.price = 20000
                appDelegate.saveContext()
            }

        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

