//
//  TodoViewModel.swift
//  ToDoList
//
//  Created by Лаборатория on 12.10.2023.
//

import Foundation

class TodoViewModel: ObservableObject {

    @Published var taskTitle: String = ""
    @Published var taskDescription: String = ""
    @Published var taskCategory: TodoCategory = .urgentImp
    @Published var deadline: Date = Date(timeIntervalSinceNow: 60 * 60 * 24)
    let categories = TodoCategory.allCases
    var newTask = true
    var todo: ToDo = ToDo()

    func setup(todo: ToDo) {
        self.newTask = false
        self.taskTitle = todo.title
        self.taskDescription = todo.taskDescription
        self.taskCategory = TodoCategory(rawValue: todo.category) ?? TodoCategory.urgentImp
        self.deadline = todo.deadline
        self.todo = todo
    }

    func saveTodo() {
        guard !taskTitle.isEmpty else { return }
        let todo = ToDo(title: self.taskTitle,
                        descrioption: self.taskDescription,
                        deadline: self.deadline,
                        category: self.taskCategory)
        RealmService.shared.createTodo(todo: todo) {
            print("Task \(todo) created!")
        }
    }

    func updateTodo() {
        guard !todo.title.isEmpty else { return }
        RealmService.shared.updateTodo(todo,
                                       title: taskTitle,
                                       desc: taskDescription,
                                       categ: taskCategory.rawValue,
                                       deadline: deadline) {
            print("Task \(todo) changed!")
        }
    }
}
