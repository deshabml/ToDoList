//
//  TodoView.swift
//  ToDoList
//
//  Created by Лаборатория on 12.10.2023.
//

import SwiftUI

struct TodoView: View {
    
    @StateObject var viewModel = TodoViewModel()
    @EnvironmentObject var coordinator: Coordinator
    @State var isEdit: Bool = false

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
            HStack {
                buttonSave
                if !isEdit {
                    buttonCanchel
                }
            }
        }
        .background {
            Image(.bg)
        }
        .padding()
        .onAppear {
            if isEdit {
                viewModel.setup(todo: coordinator.todo)
            }
        }
    }
}

#Preview {
    TodoView(viewModel: TodoViewModel())
}

extension TodoView {

    private func dismissScreen() {
        withAnimation {
            coordinator.showSetTodoView = false
        }
    }
}

extension TodoView {

    private var buttonSave: some View {
        Button {
            if let _ = viewModel.todo {
                viewModel.updateTodo()
            } else {
                viewModel.saveTodo()
            }
            coordinator.getAllTodos()
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
    }

    private var buttonCanchel: some View {
        Button {
            dismissScreen()
        } label: {
            Text("Canchel")
                .padding(.horizontal, 40)
                .padding(.vertical, 12)
                .background(.gray)
                .cornerRadius(12)
                .foregroundColor(.white)
                .fontWeight(.bold)
        }
    }
}
