//
//  SetTodoView.swift
//  ToDoList
//
//  Created by Лаборатория on 12.10.2023.
//

import SwiftUI

struct SetTodoView: View {

    @StateObject var viewModel: SetTodoViewModel
    @Environment (\.dismiss) var dismiss
    @EnvironmentObject var mainViewModel: HomeViewModel

    var body: some View {
        VStack(spacing: 16) {
            RoundedTextField(text: $viewModel.taskTitle, placeholder: "Название задачи")
            RoundedTextField(text: $viewModel.taskDescription, placeholder: "Описание задачи")
            DatePicker("Дедлайн: ",
                       selection: $viewModel.deadline)
            .datePickerStyle(.compact)
            Picker("Выберите категорию:",
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
                dismiss()
            } label: {
                Text("Сохранить")
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
