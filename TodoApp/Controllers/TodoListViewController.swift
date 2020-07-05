//
//  TodoListViewController.swift
//  TodoApp
//
//  Created by imran on 04/07/20.
//  Copyright © 2020 imran. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    var itemArray = [Item]()
    
    
    
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem  = Item.init(title: "Bread")
        itemArray.append(newItem)
        
        let newItem0  = Item.init(title: "Mango")
        itemArray.append(newItem0)
        
        let newItem1 = Item.init(title: "Apple")
        itemArray.append(newItem1)
        
        let newItem2  = Item.init(title: "Tea")
        itemArray.append(newItem2)
        
        //        todoItemArray = defaults.stringArray(forKey: "TodoItemArray") ?? todoItemArray
    }
    
    @IBAction func addNewTodoItemBtnAction(_ sender: UIBarButtonItem) {
        
        let alertController = UIAlertController.init(title: "Add New ToDo Item", message: "", preferredStyle: UIAlertController.Style.alert)
        
        
        alertController.addTextField { (textfield) in
            textfield.placeholder = "Add New Item."
            
        }
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { [weak alertController] (_) in
            alertController?.dismiss(animated: true)
        }))
        
        alertController.addAction(UIAlertAction(title: "ADD", style: .default, handler: { [weak alertController] (_) in
            let textField = alertController?.textFields![0]
            let newItem  = Item.init(title: textField!.text!)
            self.itemArray.append(newItem)
            //            self.todoItemArray.append(textField?.text ?? "")
            //            self.defaults.set(self.todoItemArray, forKey: "TodoItemArray")
            self.tableView.reloadData()
            
        }))
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
}


extension TodoListViewController {
    
    // MARK: - TableView DataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        return cell
    }
    // MARK: - TableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        let cell = tableView.cellForRow(at: indexPath)
        let item = itemArray[indexPath.row]
        cell?.accessoryType = item.done  ? .checkmark : .none
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        
        
        
    }
}
