//
//  HomeViewController.swift
//  TodoList
//
//  Created by Антон Яценко on 04.02.2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    var tasks = [Task]()
    
    private let taskList: UITableView = {
        let list = UITableView()
        list.translatesAutoresizingMaskIntoConstraints = false
        return list
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Let's Do It"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(moveToAddTaskVC))
        navigationItem.rightBarButtonItem?.style = .plain
        
        view.addSubview(taskList)
        
        setConstraints()
        setupTaskList()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        taskList.rowHeight = UITableView.automaticDimension
        taskList.estimatedRowHeight = 100
    }

    func setConstraints(){
        NSLayoutConstraint.activate([
            taskList.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            taskList.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            taskList.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            taskList.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
    
    func setupTaskList(){
        taskList.delegate = self
        taskList.dataSource = self
        taskList.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.cellIdentefier)
    }
    
    @objc func moveToAddTaskVC(){
        let addTaskViewController = AddTaskViewController()
        addTaskViewController.delegate = self
        self.present(UINavigationController(rootViewController: addTaskViewController), animated: true, completion: nil)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.cellIdentefier, for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }

        cell.configure(name: tasks[indexPath.row].name, description: tasks[indexPath.row].description)
        cell.sizeToFit()
        cell.layoutIfNeeded()
        return cell
    }
}

extension HomeViewController: AddTaskDelegate{
    func addTask(task: Task) {
        self.dismiss(animated: true){
            self.tasks.append(task)
            self.taskList.reloadData()
        }
    }
}

