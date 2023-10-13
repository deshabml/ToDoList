//
//  TodoTable.swift
//  ToDoList
//
//  Created by Лаборатория on 12.10.2023.
//

import SwiftUI

struct TodoTable: View {

    @EnvironmentObject var coordinator: Coordinator

    var body: some View {
        List {
            if !coordinator.actualTodos.isEmpty {
                Section("Current tasks:") {
                    ForEach(0 ..< coordinator.actualTodos.count, id: \.self) { index in
                        Button {
                            coordinator.goToDoDetail(coordinator.actualTodos[index])
                            /*rdinator.getPage(.todo, todo: coordinator.completedTodos[index]*/
                        } label: {
                            ToDoCell(todo: coordinator.actualTodos[index])
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button {
                                coordinator.deleteTodo(coordinator.actualTodos[index])
                            } label: {
                                Image(systemName: "trash")
                            }
                            .tint(.red)
                        }
                        .swipeActions(edge: .leading, allowsFullSwipe: true) {
                            Button {
                                coordinator.completeTodo(coordinator.actualTodos[index])
                            } label: {
                                Image(systemName: "checkmark")
                            }
                            .tint(.green)
                        }

//                        NavigationLink {
//                            TodoView(viewModel: TodoViewModel(todo: coordinator.actualTodos[index]))
//                                .environmentObject(coordinator)
//                        } label: {
//                            ToDoCell(todo: coordinator.actualTodos[index])
//                        }
//                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
//                            Button {
//                                coordinator.deleteTodo(coordinator.actualTodos[index])
//                            } label: {
//                                Image(systemName: "trash")
//                            }
//                            .tint(.red)
//                        }
//                        .swipeActions(edge: .leading, allowsFullSwipe: true) {
//                            Button {
//                                coordinator.completeTodo(coordinator.actualTodos[index])
//                            } label: {
//                                Image(systemName: "checkmark")
//                            }
//                            .tint(.green)
//                        }
                    }
                }
            }
            if (!coordinator.completedTodos.isEmpty && coordinator.showArchive) {
                Section("Completed:") {
                    ForEach(0 ..< coordinator.completedTodos.count, id: \.self) { index in
                        Button {
                            coordinator.goToDoDetail(coordinator.completedTodos[index])

//                            coordinator.getPage(.todo, todo: coordinator.completedTodos[index])
                        } label: {
                            HStack {
                                Text(coordinator.completedTodos[index].title)
                                Spacer()
                                Text(coordinator.completedTodos[index].category)
                            }                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button {
                                    coordinator.deleteTodo(coordinator.completedTodos[index])
                                } label: {
                                    Image(systemName: "trash")
                                }
                                .tint(.red)
                            }
                            .swipeActions(edge: .leading, allowsFullSwipe: true) {
                                Button {
                                    coordinator.decompleteTodo(coordinator.completedTodos[index])
                                } label: {
                                    Image(systemName: "arrow.uturn.left")
                                }

                                .tint(.orange)
                            }
                        }

//                        NavigationLink {
//                            TodoView(viewModel: TodoViewModel(todo: coordinator.completedTodos[index]))
//                                .environmentObject(coordinator)
//                        } label: {
//                            HStack {
//                                Text(coordinator.completedTodos[index].title)
//                                Spacer()
//                                Text(coordinator.completedTodos[index].category)
//                            }                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
//                                Button {
//                                    coordinator.deleteTodo(coordinator.completedTodos[index])
//                                } label: {
//                                    Image(systemName: "trash")
//                                }
//                                .tint(.red)
//                            }
//                            .swipeActions(edge: .leading, allowsFullSwipe: true) {
//                                Button {
//                                    coordinator.decompleteTodo(coordinator.completedTodos[index])
//                                } label: {
//                                    Image(systemName: "arrow.uturn.left")
//                                }
//
//                                .tint(.orange)
//                            }
//                        }
                    }
                }
            }
        }
        .listStyle(.plain)
    }
}


#Preview {
    TodoTable()
        .environmentObject(Coordinator())
}
