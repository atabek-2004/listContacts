//
//  TableViewController.swift
//  toDoList
//
//  Created by Admin on 17.10.2024.
//

import UIKit

class TableViewController: UITableViewController {
    
    var contacts: [Contact] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        if let savedContacts = UserDefaults.standard.data(forKey: "contactsArray"),
           let decodedContacts = try? JSONDecoder().decode([Contact].self, from: savedContacts) {
            contacts = decodedContacts
        }

        self.navigationItem.leftBarButtonItem = self.editButtonItem
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addContact))
        self.title = "Contacts"
    }

    @objc func addContact() {
        let addVC = AddEditViewController()
        addVC.delegate = self
        self.navigationController?.pushViewController(addVC, animated: true)
    }

    func saveContacts() {
        if let encodedContacts = try? JSONEncoder().encode(contacts) {
            UserDefaults.standard.set(encodedContacts, forKey: "contactsArray")
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let contact = contacts[indexPath.row]
        cell.textLabel?.text = "\(contact.name): \(contact.phone)"
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            contacts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveContacts()
        }
    }

    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let movedContact = contacts.remove(at: fromIndexPath.row)
        contacts.insert(movedContact, at: to.row)
        saveContacts()
    }

    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let editVC = AddEditViewController()
        editVC.delegate = self
        editVC.contact = contacts[indexPath.row]
        editVC.index = indexPath.row
        self.navigationController?.pushViewController(editVC, animated: true)
    }
}

extension TableViewController: AddEditViewControllerDelegate {
    func didAddContact(_ contact: Contact) {
        contacts.append(contact)
        tableView.reloadData()
        saveContacts()
    }
    
    func didEditContact(_ contact: Contact, at index: Int) {
        contacts[index] = contact
        tableView.reloadData()
        saveContacts()
    }
}


    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


