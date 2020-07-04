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
    
    let cellId = "CellId"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}


extension TodoListViewController {
    
    // MARK: - TableView DataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
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
