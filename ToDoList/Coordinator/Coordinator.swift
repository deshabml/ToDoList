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
    @Published var showSetTodoView: Bool = false {
        didSet {
            todoVM.setup(todo: ToDo())
        }
    }
    @Published var todos: [ToDo] = [] {
        didSet {
            self.actualTodos = todos.filter { !$0.completed }
            self.completedTodos = todos.filter { $0.completed }
        }
    }
    @Published var showTodos: Bool = true
    @Published var actualTodos: [ToDo] = []
    @Published var completedTodos: [ToDo] = []
    @Published var todoVM = TodoViewModel()
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
        RealmService.shared.deleteTodo(todo) {
            getAllTodos()
            showTodos = true
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
        todos = RealmService.shared.getTodos()
    }

    func notShowToDos(todo: ToDo) {
        showTodos = false
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(400)) { [unowned self] in
            deleteTodo(todo)
        }
    }
}
