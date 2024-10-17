//
//  ViewController.swift
//  toDoList
//
//  Created by Admin on 17.10.2024.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    @IBAction func addTask(_ sender: Any) {
        guard let task = textfield.text, !task.isEmpty else { return }
        
        var taskArray = UserDefaults.standard.array(forKey: "taskArray") as? [String] ?? [String]()
        taskArray.append(task)
        UserDefaults.standard.set(taskArray, forKey: "taskArray")
        
        
        textfield.text = ""
        
       
        let alert = UIAlertController(title: "Success", message: "Contact added successfully!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

