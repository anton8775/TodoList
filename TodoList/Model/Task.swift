//
//  Task.swift
//  TodoList
//
//  Created by Антон Яценко on 04.02.2023.
//

import Foundation

struct Task{
    var name: String
    var description: String
}

protocol AddTaskDelegate{
    func addTask(task: Task)
}
