//
//  RealmService.swift
//  ToDoList
//
//  Created by Лаборатория on 12.10.2023.
//

import Foundation
import RealmSwift

class RealmService {
    static let shared = RealmService(); private init() { }
    private let db = try! Realm()

    var config: Realm.Configuration {
        db.configuration
    }

    //MARK: Create
    func createTodo(todo: ToDo, completion: () -> ()) {
        do {
            try db.write {
                db.add(todo)
                completion()
            }
        } catch { print("БД не работает") }
    }

    //MARK: Retrieve
    func getTodos() -> [ToDo] {
        let todoList = db.objects(ToDo.self)
        var todos = [ToDo]()
        for todo in todoList {
            todos.append(todo)
        }
        return todos
    }

    //MARK: Update
    func updStatus(_ value: Bool, for todo: ToDo, completion: () -> ()) {
        do {
            try db.write {
                todo.completed = value
                completion()
            }
        } catch { print(error) }
    }

    func updateTodo(_ todo: ToDo,
                    title: String,
                    desc: String,
                    categ: String,
                    deadline: Date,
                    comletion: () -> ()) {
        do {
            try db.write {
                todo.title = title
                todo.taskDescription = desc
                todo.deadline = deadline
                todo.category = categ
                comletion()
            }
        } catch { print(error) }
    }


    //MARK: Delete
    func deleteTodo(_ todo: ToDo, completion: ()->()) {
        do {
            try db.write {
                db.delete(todo)
                completion()
            }
        } catch { print("Удаление не работает") }
    }
}

