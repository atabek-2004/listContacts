//
//  AddEditViewController.swift
//  toDoList
//
//  Created by Admin on 17.10.2024.
//

import UIKit

protocol AddEditViewControllerDelegate: AnyObject {
    func didAddContact(_ contact: Contact)
    func didEditContact(_ contact: Contact, at index: Int)
}

class AddEditViewController: UIViewController {

    weak var delegate: AddEditViewControllerDelegate?
    var contact: Contact?
    var index: Int?

    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.placeholder = "Name"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let phoneTextField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.placeholder = "Phone"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.keyboardType = .phonePad
        return tf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        
        if let contact = contact {
            nameTextField.text = contact.name
            phoneTextField.text = contact.phone
            self.title = "Edit Contact"
        } else {
            self.title = "Add Contact"
        }
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveContact))
    }
    
    func setupLayout() {
        view.addSubview(nameTextField)
        view.addSubview(phoneTextField)
        
        NSLayoutConstraint.activate([
            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            phoneTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            phoneTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            phoneTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            phoneTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    @objc func saveContact() {
        guard let name = nameTextField.text, !name.isEmpty,
              let phone = phoneTextField.text, !phone.isEmpty else { return }
        
        let newContact = Contact(name: name, phone: phone)
        
        if let index = index {
            delegate?.didEditContact(newContact, at: index)
        } else {
            delegate?.didAddContact(newContact)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
}
