//
//  TodoListViewController.swift
//  TodoApp
//
//  Created by imran on 04/07/20.
//  Copyright © 2020 imran. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    var todoItemArray = ["Mango","Tea","Bread"]
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        todoItemArray = defaults.stringArray(forKey: "TodoItemArray") ?? todoItemArray
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
            self.todoItemArray.append(textField?.text ?? "")
            self.defaults.set(self.todoItemArray, forKey: "TodoItemArray")
            self.tableView.reloadData()
           
        }))
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
}


extension TodoListViewController {
    
    // MARK: - TableView DataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath)
        cell.textLabel?.text = todoItemArray[indexPath.row]
        return cell
    }
    // MARK: - TableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        if cell!.accessoryType == .checkmark{
            cell?.accessoryType = .none
        } else{
             cell?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)

    }
}
