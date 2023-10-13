//
//  HomeView.swift
//  ToDoList
//
//  Created by Лаборатория on 12.10.2023.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var coordinator: Coordinator
    
    var body: some View {
        ZStack {
            VStack {
                if coordinator.todos.isEmpty {
                    thereIsNoTask()
                } else {
                    TodoTable()
                        .environmentObject(coordinator)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background{
                Image(.bgHome)
                    .ignoresSafeArea()
                    .scaledToFill()
            }
            .onAppear {
                coordinator.getAllTodos()
            }
            .overlay(alignment: .bottomTrailing) {
                buttonPlus()
            }
            popUpScreenTodoView()
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(Coordinator())
}

extension HomeView {
    
    private func buttonPlus() -> some View {
        Button {
            withAnimation {
                coordinator.showSetTodoView.toggle()
            }
        } label: {
            Image(systemName: "plus")
                .font(.title2)
                .bold()
                .padding()
                .foregroundColor(.white)
                .background(.mint)
                .cornerRadius(40)
                .padding(8)
        }
    }
    
    private func thereIsNoTask() -> some View {
        Text("There are no tasks yet! Add the first one!")
            .padding()
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
    private func popUpScreenTodoView() -> some View {
        Group {
            if coordinator.showSetTodoView {
                Rectangle()
                    .ignoresSafeArea()
                    .opacity(0.3)
                    .onTapGesture {
                        withAnimation {
                            coordinator.showSetTodoView.toggle()
                        }
                    }
                TodoView(viewModel: TodoViewModel())
                    .environmentObject(coordinator)
                    .background {
                        Image(.bg)
                    }
                    .transition(.move(edge: .bottom))
                    .cornerRadius(18)
                    .shadow(radius: 2)
                    .padding()
            }
        }
    }
}
