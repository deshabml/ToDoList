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
        VStack {
            ZStack {
                TodoTable()
                    .environmentObject(coordinator)
                thereIsNoTask()
                popUpScreenTodoView()
            }
            .overlay(alignment: .bottomTrailing) {
                buttonPlus()
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
        Group {
            if coordinator.todos.isEmpty {
                Text("There are no tasks yet! Add the first one!")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.white)
            }
        }
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
