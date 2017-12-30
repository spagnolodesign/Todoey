//
//  ViewController.swift
//  Todoey
//
//  Created by Luca Spagnolo on 29/12/2017.
//  Copyright © 2017 Luca Spagnolo. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.text
        cell.accessoryType = (item.done) ? .checkmark : .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = itemArray[indexPath.row]
        item.done = !item.done
        tableView.deselectRow(at: indexPath, animated: true)
        saveData(data: self.itemArray, path: self.dataFilePath!)
        tableView.reloadData()
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new item to the list", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) {
            (action) in
            let newItem = Item()
                newItem.text = textField.text!
            
            self.itemArray.append(newItem)
            
            self.saveData(data: self.itemArray, path: self.dataFilePath!)
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Type a title."
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
    }
    
    
    func saveData(data: [Item], path: URL) {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(data)
            try data.write(to: path)
        } catch {
            print("error occured")
        }
    }
    
    func loadData(){
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("There is been a problem by decoding data")
            }
        }
        
    }
}

