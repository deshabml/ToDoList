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
                Section {
                    ForEach(0 ..< coordinator.actualTodos.count, id: \.self) { index in
                        buttonCellActulalTodos(index: index)
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
                    ForEach(0 ..< coordinator.completedTodos.count, id: \.self) { index in
                        buttonCellCompletedTodos(index: index)
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
    private func buttonCellActulalTodos(index: Int) -> some View {
        Button {
            coordinator.goToDoDetail(coordinator.actualTodos[index])
        } label: {
            ToDoCell(viewModel: ToDoCellViewModel(todo: coordinator.actualTodos[index]))
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
    }

    @ViewBuilder
    private func buttonCellCompletedTodos(index: Int) -> some View {
        Button {
            coordinator.goToDoDetail(coordinator.completedTodos[index])
        } label: {
            HStack {
                Text(coordinator.completedTodos[index].title)
                Spacer()
                Text(coordinator.completedTodos[index].category)
            }
            .padding()
            .background(Color(.liteGrey).opacity(0.5))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
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
    }
}
