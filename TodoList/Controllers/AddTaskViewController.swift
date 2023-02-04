//
//  AddTaskViewController.swift
//  TodoList
//
//  Created by Антон Яценко on 04.02.2023.
//

import UIKit

class AddTaskViewController: UIViewController {
    
    var delegate: AddTaskDelegate?
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var nameTextField: UITextField = {
        let name = UITextField()
        name.layer.shadowOpacity = 0.2
        name.layer.shadowRadius = 0.7
        name.layer.shadowColor = UIColor.black.cgColor
        name.borderStyle = .roundedRect
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private var descriptionTextField: UITextField = {
        let description = UITextField()
        description.layer.shadowOpacity = 0.2
        description.layer.shadowRadius = 0.7
        description.layer.shadowColor = UIColor.black.cgColor
        description.borderStyle = .roundedRect
        description.translatesAutoresizingMaskIntoConstraints = false
        return description
    }()
    private let addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemGray4
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        view.addSubview(descriptionLabel)
        view.addSubview(descriptionTextField)
        view.addSubview(addButton)
        
        nameLabel.text = "Name"
        descriptionLabel.text = "Description"
        nameTextField.becomeFirstResponder()
        
       addButton.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
        setConstraints()
    }
    
    func setConstraints(){
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            nameLabel.widthAnchor.constraint(equalToConstant: 60),

            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),

            descriptionLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 26),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            descriptionLabel.widthAnchor.constraint(equalToConstant: 120),

            descriptionTextField.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            descriptionTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            descriptionTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),

            addButton.topAnchor.constraint(equalTo: descriptionTextField.bottomAnchor, constant: 42),
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80)
        ])
    }
    
    @objc func handleSave(){
        guard let name = nameTextField.text, nameTextField.hasText else { return }
        guard let description = descriptionTextField.text, descriptionTextField.hasText else { return }
        
        let task = Task(name: name, description: description)
        
        delegate?.addTask(task: task)
    }
}

