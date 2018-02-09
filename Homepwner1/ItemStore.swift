//
//  ItemStore.swift
//  Homepwner1
//
//  Created by Steve Duran on 9/26/17.
//  Copyright © 2017 Steve Duran. All rights reserved.
//

import Foundation
import UIKit
class ItemStore{
    
    // an array of Item objects 
    var allItems = [Item]()
    
    //loading archive files tht we saved
    init() {
        if let archivedItems =
            NSKeyedUnarchiver.unarchiveObject(withFile: itemArchiveURL.path) as? [Item] {
            allItems = archivedItems }
    }
    
    let itemArchiveURL : URL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("items.archive")
        
    }()
    

    @discardableResult func createItem() -> Item {
        let newItem = Item(random: true)
        
        allItems.append(newItem)
        
        return newItem
    }
    
    func removeItem(item: Item) {
        
        if let index = allItems.index(of: item) {
            allItems.remove(at: index)
        }
    }
    
    //saving infomation after app closes
    func saveChanges() -> Bool {
        print("Saving items to: \(itemArchiveURL.path)")
        return NSKeyedArchiver.archiveRootObject(allItems, toFile: itemArchiveURL.path)
    }
    
    func moveItem(from fromIndex: Int, to toIndex: Int){
        
        // Get reference to object being moved so it can be inserted
        let moveItem = allItems[fromIndex]
        
        // Remove item from array
        allItems.remove(at: fromIndex)
        
        // Insert item in array at new location
        allItems.insert(moveItem, at: toIndex)
    }
    
  
}
