//
//  HomeViewModel.swift
//  ToDoList
//
//  Created by Лаборатория on 12.10.2023.
//

import Foundation

class HomeViewModel: ObservableObject {

    @Published var todos: [ToDo] = []
    var showArchive: Bool {
        let showArchive = UserDefaults.standard.bool(forKey: PersistedKey.showArchive.rawValue)
        return showArchive
    }
    var actualTodos: [ToDo] { todos.filter { !$0.completed } }
    var completedTodos: [ToDo] { todos.filter { $0.completed } }


    func getAllTodos() {
        self.todos = RealmService.shared.getTodos()
    }

    func deleteTodo(_ todo: ToDo) {

        todos.removeAll()
        RealmService.shared.deleteTodo(todo) {
            getAllTodos()
        }
    }

    func completeTodo(_ todo: ToDo) {
        RealmService.shared.updStatus(true, for: todo) {
            getAllTodos()
        }
    }

    func decompleteTodo(_ todo: ToDo) {
        RealmService.shared.updStatus(false, for: todo) {
            getAllTodos()
        }
    }

}
