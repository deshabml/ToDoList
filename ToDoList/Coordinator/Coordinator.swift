//
//  Coordinator.swift
//  ToDoList
//
//  Created by Лаборатория on 12.10.2023.
//

import SwiftUI

@MainActor
final class Coordinator: ObservableObject {

    @Published var path = NavigationPath()
    @Published var page: MyPage = .home
    @Published var tab: MyTab = MyTab.home
    @Published var showSetTodoView: Bool = false
    @Published var todos: [ToDo] = []
    var actualTodos: [ToDo] { todos.filter { !$0.completed } }
    var completedTodos: [ToDo] { todos.filter { $0.completed } }
    var showArchive: Bool {
        let showArchive = UserDefaults.standard.bool(forKey: PersistedKey.showArchive.rawValue)
        return showArchive
    }
    var todo = ToDo()

    init() {
        getAllTodos()
    }

    func goHome() {
        path.removeLast(path.count)
    }

    func goToDoDetail(_ todo: ToDo) {
        self.todo = todo
        path.append(MyPage.todo)
    }

    @ViewBuilder
    func getPage(_ page: MyPage) -> some View {
        switch page {
            case .home:
                HomeView()
            case .todo:
                TodoView(isEdit: true)
            case .settings:
                SettingsView()
        }
    }

}

extension Coordinator {

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

    func getAllTodos() {
        self.todos = RealmService.shared.getTodos()
    }
}
