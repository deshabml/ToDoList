//
//  TodoTable.swift
//  ToDoList
//
//  Created by Лаборатория on 12.10.2023.
//

import SwiftUI

struct TodoTable: View {

    @EnvironmentObject var coordinator: Coordinator
    var columns = [GridItem(.flexible())]


    var body: some View {
        List {
            if !coordinator.actualTodos.isEmpty {
                Section {
                    ForEach(coordinator.actualTodos) { todo in
                        buttonCellActulalTodos(todo: todo)
                    }
                    .listRowBackground(Color.clear)
                } header: {
                    Text("Current tasks:")
                        .padding(.horizontal)
                        .padding(.vertical, 6)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                }
            }
            if (!coordinator.completedTodos.isEmpty && coordinator.showArchive) {
                Section {
                    ForEach(coordinator.completedTodos) { todo in
                        buttonCellCompletedTodos(todo: todo)
                    }
                    .listRowBackground(Color.clear)
                } header: {
                    Text("Completed:")
                        .padding(.horizontal)
                        .padding(.vertical, 6)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                }
            }
        }
        .listStyle(.plain)
    }
}


#Preview {
    VStack {
        TodoTable()
            .environmentObject(Coordinator())
    }
    .background(Image(.bgHome))
}

extension TodoTable {

    @ViewBuilder
    private func buttonCellActulalTodos(todo: ToDo) -> some View {
        Button {
            coordinator.goToDoDetail(todo)
        } label: {
            ToDoCell(viewModel: ToDoCellViewModel(todo: todo))
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            Button {
                coordinator.notShowToDos(todo: todo)
            } label: {
                Image(systemName: "trash")
            }
            .tint(.red)
        }
        .swipeActions(edge: .leading, allowsFullSwipe: true) {
            Button {
                coordinator.completeTodo(todo)
            } label: {
                Image(systemName: "checkmark")
            }
            .tint(.green)
        }
    }

    @ViewBuilder
    private func buttonCellCompletedTodos(todo: ToDo) -> some View {
        Button {
            coordinator.goToDoDetail(todo)
        } label: {
            HStack {
                Text(todo.title)
                Spacer()
                Text(todo.category)
            }
            .padding()
            .background(Color(.liteGrey).opacity(0.5))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                Button {
                    coordinator.notShowToDos(todo: todo)
                } label: {
                    Image(systemName: "trash")
                }
                .tint(.red)
            }
            .swipeActions(edge: .leading, allowsFullSwipe: true) {
                Button {
                    coordinator.decompleteTodo(todo)
                } label: {
                    Image(systemName: "arrow.uturn.left")
                }
                .tint(.orange)
            }
        }
    }
}
