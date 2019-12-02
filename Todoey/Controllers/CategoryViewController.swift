//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Vikas Kumar on 11/10/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categories = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
    }
//MARK: - tableview datasource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell" , for: indexPath)
        cell.textLabel?.text = categories[indexPath.row].name
        return cell
    }
    
    //MARK: - data manipulation methods
    
    //MARK: - add new categories
    
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
    }
    //MARK: - TableView Datasource Methods
    
    //MARK: - tableview delegate methods
    
    //MARK: - data manipulation methods

}
