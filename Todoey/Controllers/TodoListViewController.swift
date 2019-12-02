

import UIKit
import CoreData

class TodoListViewController: UITableViewController  {
   // , UISearchBarDelegate , UIPickerViewDelegate , UIImagePickerControllerDelegate
    //var itemArray = ["find Mike", "Buy Eggos", "Destroy Demogorgon"]
    var itemArray = [Item]()
    //    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    //    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print( FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
       // searchBar.delegate = self
        
        //print(dataFilePath)
        
        //
        
     //  loadItems(with: request)
        
        //        itemArray.append(newItem3)
        //        itemArray.append(newItem3)
        //        itemArray.append(newItem3)
        //        itemArray.append(newItem3)
        //        itemArray.append(newItem3)
        //        itemArray.append(newItem3)
        //        itemArray.append(newItem3)
        //        itemArray.append(newItem3)
       loadItems()
        
        // Do any additional setup after loading the view.
        //        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
        //            itemArray = items
        //        }
    }
    //MARK: - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //   let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done == true ? .checkmark : .none
        //        if item.done == true {
        //            cell.accessoryType = .checkmark
        //        } else {
        //            cell.accessoryType = .none
        //        }
        return cell
    }
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        // tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//       // itemArray[indexPath.row].setValue("completed", forKey: "title")
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
        
       itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        //        if itemArray[indexPath.row].done == false {
        //            itemArray[indexPath.row].done = true
        //        } else {
        //            itemArray[indexPath.row].done = false
        //        }
        
        //        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
        //            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        //        } else {
        //            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        //        }
      //  tableView.reloadData()
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) {  (action) in
            //what will happen once the user clicks the add item button on our UIAlert
            //print("success")
            //  print(textField.text)
            
            // let context = AppDelegate.persistentContainer.viewContext
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            self.itemArray.append(newItem)
            
            // self.defaults.set(self.itemArray,forKey: "TodoListArray")
            //            let encoder = PropertyListEncoder()
            //            do{
            //                let data = try encoder.encode(self.itemArray)
            //                try data.write(to: self.dataFilePath!)
            //            } catch {
            //                print("Error encoding item array,  \(error)")
            //            }
            //            self.tableView.reloadData()
            self.saveItems()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Item"
            textField = alertTextField
            //            print(alertTextField)
            //            print("Now")
        }
        alert.addAction(action)
        present(alert , animated:true,completion: nil)
    }
    //MARK: - model manupulation methods
    
    func saveItems() {
        //  let encoder = PropertyListEncoder()
        do{
            try context.save()
            //            let data = try encoder.encode(self.itemArray)
            //            try data.write(to: self.dataFilePath!)
        } catch {
            //            print("Error encoding item array,  \(error)")
            print("Error saving context \(error)")
        }
        self.tableView.reloadData()
    }
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()) {
        //        if let data = try? Data(contentsOf: dataFilePath!) {
        //            let decoder = PropertyListDecoder()
        //            do {
        //            itemArray = try decoder.decode([Item].self, from: data)
        //               // try context.save()
        //            } catch {
        ////                print("Error decoding item array, \(error)")
        //                print("Error decoding item array, \(error)")
       // let request : NSFetchRequest<Item> = Item.fetchRequest()
        do {
          itemArray =  try context.fetch(request)
        } catch {
            print("ERROR FETCHING data from context\(error)")
        }
        
    }
        
    }
    //MARK: - search bar methods
extension TodoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        //  print(searchBar.text!)
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        //request.predicate = predicate
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        //request.sortDescriptors = [sortDescriptor]
        loadItems(with: request)
        //            do {
        //              itemArray =  try context.fetch(request)
        //            } catch {
        //                print("ERROR FETCHING data from context\(error)")
        //            }
        //tableView.reloadData()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
          
            
        }
    }
}

