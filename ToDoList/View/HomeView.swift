//
//  HomeView.swift
//  ToDoList
//
//  Created by Лаборатория on 12.10.2023.
//

import SwiftUI

struct HomeView: View {

    @StateObject var viewModel = HomeViewModel()
    @State var showSetTodoView = false

    var body: some View {
        NavigationView {
            ZStack {
                TodoTable()
                    .environmentObject(viewModel)
                if viewModel.todos.isEmpty {
                    Text("Задач ещё нет! Добавьте первую!")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.white)
                }
                if showSetTodoView {
                    Rectangle()
                        .ignoresSafeArea()
                        .opacity(0.3)
                        .onTapGesture {
                            withAnimation {
                                showSetTodoView.toggle()
                            }
                        }
                    SetTodoView(viewModel: SetTodoViewModel())
                        .environmentObject(viewModel)
                        .background {
                            Image("bg")
                        }
                        .transition(.move(edge: .bottom))
                        .cornerRadius(18)
                        .shadow(radius: 2)
                        .padding()
                }
            }
            .overlay(alignment: .bottomTrailing) {
                Button {
                    withAnimation {
                        showSetTodoView.toggle()
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

        }
        .onAppear {
            viewModel.getAllTodos()
        }
    }
}

#Preview {
    HomeView()
}
