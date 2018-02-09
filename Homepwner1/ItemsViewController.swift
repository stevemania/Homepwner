//
//  ItemsViewController.swift
//  Homepwner1
//
//  Created by Steve Duran on 9/26/17.
//  Copyright © 2017 Steve Duran. All rights reserved.
//

import Foundation
import UIKit

class ItemsViewController : UITableViewController
{
    //gives access to imageStore
    var itemStore : ItemStore!
    var imageStore: ImageStore!
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count
    }
    
    // Row display
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        // Set the text on the cell with the description of the item
        // that is at the nth index of items, where n = row this cell
        // will appear in on the tableview
        let item = itemStore.allItems[indexPath.row]
        
        cell.nameLabel.text = item.name
        cell.textLabel?.text = item.serialNumber
        cell.valueLabel.text = "$\(item.valueInDollars)"
        
        return cell
    }
    
    // Row delete
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        // If the tableview is asking to commit a delete command ...
        if editingStyle == .delete {
        
            let item = itemStore.allItems[indexPath.row];
            
            let title = "Delete \(item.name)?"
            let message = "Are you sure you want to delete this item?"
            
            let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            ac.addAction(cancelAction)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: {(sender) -> Void in
                
                // Remove the item from the store
                self.itemStore.removeItem(item: item)
                
                
                // Remove the item's image from the image store
                self.imageStore.deleteImage(forKey: item.itemKey)
                
                // Also remove the row from the table view with an animation
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            })
            
            ac.addAction(deleteAction)
            
            present(ac, animated: true, completion: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        // Update the model
        itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 65
    }
    
    // UIBUtton changed to UIBARBUtton because we are using UINavigavtion
    @IBAction func addNewItem(_ sender: UIBarButtonItem){
        
        // Create a new item and add it to the item store
        let newItem = itemStore.createItem()
        
        if let index = itemStore.allItems.index(of: newItem) {
            
            let indexPath = IndexPath(row: index, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // If the triggered segue is the "showItem" segue
        switch segue.identifier {
        case "showItem"?:
            // Figure out which row was just tapped
            if let row = tableView.indexPathForSelectedRow?.row {
                // Get the item associated with this row and pass it along
                let item = itemStore.allItems[row]
                let detailViewController
                    = segue.destination as! DetailViewController
                detailViewController.item = item
                detailViewController.imageStore = imageStore //shows image 
            }default:
                preconditionFailure("Unexpected segue identifier.")
        
        }
    }
    
    //everytime we come back to this VIEW we want to update information
    //if changed in segue view controller
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData() }

    
   
    
    //programmatically inserting edit button on the navigation screen
    // have to do it programmatically
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
}
