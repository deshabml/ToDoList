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
                    thereIsNoTask
                } else {
                    if coordinator.showTodos {
                        TodoTable()
                            .environmentObject(coordinator)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background{
                Image(.bgHome)
                    .ignoresSafeArea()
                    .scaledToFill()
            }
            .overlay(alignment: .bottomTrailing) {
                buttonPlus
            }
            popUpScreenTodoView
        }
        .animation(Animation.easeInOut(duration: 0.1), value: coordinator.showTodos)

    }
}

#Preview {
    HomeView()
        .environmentObject(Coordinator())
}

extension HomeView {

    private var buttonPlus: some View {
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

    private var thereIsNoTask: some View {
        Text("There are no tasks yet! Add the first one!")
            .padding()
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }

    private var popUpScreenTodoView: some View {
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
                TodoView(viewModel: coordinator.todoVM)
                    .environmentObject(coordinator)
                    .transition(.move(edge: .bottom))
                    .cornerRadius(18)
                    .shadow(radius: 2)
                    .padding()
            }
        }
    }
}
