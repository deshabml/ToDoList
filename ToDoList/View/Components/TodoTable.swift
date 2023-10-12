//
//  TodoTable.swift
//  ToDoList
//
//  Created by Лаборатория on 12.10.2023.
//

import SwiftUI

struct TodoTable: View {

    @EnvironmentObject var viewModel: HomeViewModel

    var body: some View {
        List {
            if !viewModel.actualTodos.isEmpty {
                Section("Актуальные задачи:") {
                    ForEach(0 ..< viewModel.actualTodos.count, id: \.self) { index in
                        NavigationLink {
                            SetTodoView(viewModel: SetTodoViewModel(todo: viewModel.actualTodos[index]))
                                .environmentObject(viewModel)
                        } label: {
                            ToDoCell(todo: viewModel.actualTodos[index])
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button {
                                viewModel.deleteTodo(viewModel.actualTodos[index])
                            } label: {
                                Image(systemName: "trash")
                            }
                            .tint(.red)
                        }
                        .swipeActions(edge: .leading, allowsFullSwipe: true) {
                            Button {
                                viewModel.completeTodo(viewModel.actualTodos[index])
                            } label: {
                                Image(systemName: "checkmark")
                            }
                            .tint(.green)
                        }
                    }
                }
            }
            if (!viewModel.completedTodos.isEmpty && viewModel.showArchive) {
                Section("Выполненные:") {
                    ForEach(0 ..< viewModel.completedTodos.count, id: \.self) { index in

                        NavigationLink {
                            SetTodoView(viewModel: SetTodoViewModel(todo: viewModel.completedTodos[index]))
                                .environmentObject(viewModel)
                        } label: {
                            HStack {
                                Text(viewModel.completedTodos[index].title)
                                Spacer()
                                Text(viewModel.completedTodos[index].category)
                            }                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button {
                                    viewModel.deleteTodo(viewModel.completedTodos[index])
                                } label: {
                                    Image(systemName: "trash")
                                }
                                .tint(.red)
                            }
                            .swipeActions(edge: .leading, allowsFullSwipe: true) {
                                Button {
                                    viewModel.decompleteTodo(viewModel.completedTodos[index])
                                } label: {
                                    Image(systemName: "arrow.uturn.left")
                                }

                                .tint(.orange)
                            }
                        }
                    }
                }
            }
        }
        .listStyle(.plain)
    }
}


#Preview {
    TodoTable()
}
