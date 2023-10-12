//
//  SetTodoView.swift
//  ToDoList
//
//  Created by Лаборатория on 12.10.2023.
//

import SwiftUI

struct SetTodoView: View {

    @StateObject var viewModel: SetTodoViewModel
    @EnvironmentObject var mainViewModel: HomeViewModel

    var body: some View {
        VStack(spacing: 16) {
            RoundedTextField(text: $viewModel.taskTitle, placeholder: "Task name")
            RoundedTextField(text: $viewModel.taskDescription, placeholder: "Task description")
            DatePicker("Deadline: ",
                       selection: $viewModel.deadline)
            .datePickerStyle(.compact)
            Picker("Select a category:",
                   selection: $viewModel.taskCategory) {
                ForEach(viewModel.categories, id: \.self) { category in
                    Text(category.rawValue).tag(category)
                }
            }
            Button {
                if let _ = viewModel.todo {
                    viewModel.updateTodo()
                } else {
                    viewModel.saveTodo()
                }
                mainViewModel.getAllTodos()
                dismissScreen()
            } label: {
                Text("Save")
                    .padding(.horizontal, 40)
                    .padding(.vertical, 12)
                    .background(.blue)
                    .cornerRadius(12)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
            }
        }.padding()
    }
}


#Preview {
    SetTodoView(viewModel: SetTodoViewModel())
}

extension SetTodoView {

    private func dismissScreen() {
        withAnimation {
            mainViewModel.showSetTodoView = false
        }
    }
}
