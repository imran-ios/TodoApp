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
    
 let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItem()
        
    
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
            self.saveData()
           
            
            
        }))
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    
    func saveData()  {
        let encoder  = PropertyListEncoder()
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to:dataFilePath!)
        }
        catch{
            print("Faile to store data")
        }
        
        tableView.reloadData()

    }
    
    func loadItem()  {
        if let data = try? Data.init(contentsOf: dataFilePath!) {
            let decoder  = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
                try data.write(to:dataFilePath!)
                tableView.reloadData()
            } catch{
                print("Failed to retrive data")
            }
        }
        
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
        cell.accessoryType = item.done  ? .checkmark : .none
        
        return cell
    }
    
    
    
    // MARK: - TableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        DispatchQueue.main.async {
            tableView.deselectRow(at: indexPath, animated: true)
            self.saveData()
        }
    }
}
